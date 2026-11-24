import argparse,sys,threading,time
from http.server import ThreadingHTTPServer
from pathlib import Path
from playwright.sync_api import sync_playwright

ROOT=Path.cwd();sys.path.insert(0,str(ROOT/'web'))
import server
server.prepare_lean()
server.Handler.opts=argparse.Namespace(jobs=4,timeout=60)
server.Handler.cache=server.Cache()
httpd=ThreadingHTTPServer(('127.0.0.1',0),server.Handler)
thread=threading.Thread(target=httpd.serve_forever,daemon=True);thread.start()
base=f'http://127.0.0.1:{httpd.server_address[1]}'
try:
 with sync_playwright() as p:
  browser=p.chromium.launch(headless=True,args=['--disable-dev-shm-usage'])
  page=browser.new_page()
  errors=[];console_errors=[]
  page.on('pageerror',lambda e:errors.append(str(e)))
  page.on('console',lambda m:console_errors.append(m.text) if m.type=='error' else None)
  started=time.time()
  for i in range(1,16):
   level=f'T{i}';expected=len(server.load_level(level)['tests'])
   page.goto(f'{base}/?level={level}',wait_until='networkidle')
   page.wait_for_function("!document.querySelector('#run').disabled")
   assert page.evaluate("document.querySelector('#src') !== null")
   code=(ROOT/'variants'/level/'correct.lean').read_text()
   page.evaluate("code => { const el=document.querySelector('#src'); el.value=code; el.dispatchEvent(new Event('input',{bubbles:true})); }",code)
   page.click('#run')
   page.wait_for_function("document.querySelector('#summary').textContent.includes('Level cleared')",timeout=120000)
   score=page.locator('#summary .score').inner_text()
   assert score==f'{expected}/{expected} passed on this code',(level,score,expected)
   assert not errors,(level,errors)
   print(f'{level}: UI Level cleared, {score}; no page errors.',flush=True)
   if i==1:
    page.click('#next')
    page.wait_for_function("location.search.includes('level=T2')")
  page.click('#next')
  page.wait_for_function("location.search.includes('level=58')")
  print('T15 next step is the mathematical-auditing coda at L58.')
  assert not errors,errors
  print(f'All 15 levels cleared through the browser UI in {time.time()-started:.1f}s; Next navigation and the T15-to-coda transition passed.')
  if console_errors: print('Console errors (information may include third-party analytics):',console_errors)
  browser.close()
finally:
 httpd.shutdown();httpd.server_close();thread.join()

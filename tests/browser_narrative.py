"""Browser regression for the three-act order and representative playable levels."""
import argparse,sys,threading,time
from http.server import ThreadingHTTPServer
from pathlib import Path
from playwright.sync_api import sync_playwright

ROOT=Path(__file__).resolve().parent.parent
sys.path.insert(0,str(ROOT/'web'))
import server

server.prepare_lean()
server.Handler.opts=argparse.Namespace(jobs=4,timeout=60)
server.Handler.cache=server.Cache()
httpd=ThreadingHTTPServer(('127.0.0.1',0),server.Handler)
thread=threading.Thread(target=httpd.serve_forever,daemon=True);thread.start()
base=f'http://127.0.0.1:{httpd.server_address[1]}'
expected=list(range(1,58))+[f'T{i}' for i in range(1,16)]+[58,59,60]
assert server.LEVELS==expected
selected=['1','23','39','T15']
try:
 with sync_playwright() as p:
  browser=p.chromium.launch(headless=True,args=['--disable-dev-shm-usage'])
  page=browser.new_page();errors=[]
  page.on('pageerror',lambda e:errors.append(str(e)))
  started=time.time()
  for n in expected:
   ident=str(n);lv=server.load_level(n)
   page.goto(f'{base}/?level={ident}',wait_until='networkidle')
   page.wait_for_function("!document.querySelector('#run').disabled")
   assert lv['title'] in page.title(),(ident,page.title(),lv['title'])
   intro=page.locator('#intro').inner_text()
   assert 'ACT I — SEQUENCES' in intro if lv['num']<=33 else True,ident
   assert 'ACT II — LIMITS' in intro if 34<=lv['num']<=43 and lv['id'] not in [58,59,60] else True,ident
   assert 'ACT III — TOPOLOGY' in intro if lv['num']>43 else True,ident
   if ident in selected:
    code=next((ROOT/'variants'/server.level_dir(n)).glob('correct*.lean')).read_text()
    page.evaluate("code => { const el=document.querySelector('#src'); el.value=code; el.dispatchEvent(new Event('input',{bubbles:true})); }",code)
    if page.locator('#predict').is_visible():
     page.click('#predict-skip')
    page.click('#run')
    page.wait_for_function("document.querySelector('#summary').textContent.includes('Level cleared')",timeout=120000)
    total=len(lv['tests'])
    assert page.locator('#summary .score').inner_text()==f'{total}/{total} passed on this code'
    print(f'{ident}: story and UI solution pass ({total}/{total}).',flush=True)
  page.goto(f'{base}/?level=T15',wait_until='networkidle')
  page.wait_for_function("document.querySelector('#next') !== null")
  page.click('#next')
  page.wait_for_function("location.search.includes('level=58')")
  assert not errors,errors
  print(f'All 75 lessons displayed in the three-act order; T15 leads to the coda. {time.time()-started:.1f}s.')
  browser.close()
finally:
 httpd.shutdown();httpd.server_close();thread.join()

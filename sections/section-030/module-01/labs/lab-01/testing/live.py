import json,subprocess,time,sys,tempfile,os

def call(*args):
 r=subprocess.run(list(args),text=True,capture_output=True,timeout=20)
 assert r.returncode==0, 'Observation command failed: '+args[0]
 return r.stdout.strip()
def obj(kind,name,ns='starfleet'):
 return json.loads(call('kubectl',*(['-n',ns] if ns else []),'get',kind,name,'-o','json'))
def api(path):
 script='import urllib.request; print(urllib.request.urlopen('+repr('http://prometheus:9090'+path)+',timeout=8).read().decode())'
 return json.loads(call('kubectl','-n','starfleet','exec','shuttle','--','python','-c',script))
def save(data):
 resource={'apiVersion':'v1','kind':'ConfigMap','metadata':{'name':'evidence','namespace':'starfleet'},'data':{'report.json':json.dumps(data,sort_keys=True)}}
 with tempfile.NamedTemporaryFile(mode='w',suffix='.json',delete=False) as f:json.dump(resource,f);path=f.name
 try:call('kubectl','apply','-f',path)
 finally:os.unlink(path)

recorded=json.loads(obj("configmap","evidence")["data"]["report.json"])
import ipaddress
nodes=json.loads(call('kubectl','get','nodes','-o','json'))['items']
networks=[ipaddress.ip_network(n['spec']['podCIDR']) for n in nodes]
assert len(networks)==2 and not networks[0].overlaps(networks[1])
observed={'pod_cidrs':{n['metadata']['name']:n['spec']['podCIDR'] for n in nodes},'ipam':obj('configmap','cilium-config','kube-system')['data']['ipam']}
assert recorded == observed, "Evidence differs from the live observation"

#!/usr/bin/env python3
import json
from pathlib import Path
p=Path('pcd.json')
data=json.loads(p.read_text())
for key in ['name','version','description','arr_types','dependencies','profilarr']:
    assert key in data, f'Missing {key}'
print('pcd.json looks valid')

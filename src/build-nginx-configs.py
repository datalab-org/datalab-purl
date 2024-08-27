# /// script
# dependencies = [
#     "pyyaml ~= 6.0",
#     "jinja2 ~= 3.1",
# ]
# ///

from yaml import safe_load
from jinja2 import Template
from pathlib import Path
import os

COMBINED_FILE = os.environ.get("COMBINED_FILE", "/app/combined.yaml")

include_dir = Path("/app/nginx/include")
include_dir.mkdir(parents=True, exist_ok=True)

with open(COMBINED_FILE) as f:
    provider_list = safe_load(f)

template = Template(
    (Path(__file__).parent / "templates" / "nginx-provider.conf.j2").read_text()
)

with open(include_dir / "providers-nginx.conf", "w") as f:
    f.write(template.render(providers=provider_list))

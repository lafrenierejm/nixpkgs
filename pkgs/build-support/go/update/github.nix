{ writeScript }:
{
  pname,
  owner,
  repo,
}: writeScript "update.sh" ''
#!/usr/bin/env nix-shell
#!nix-shell -i bash -p curl jq nix-prefetch-github gnused
set -euo pipefail

response="$(curl -sS https://api.github.com/repos/${owner}/${repo}/releases/latest)"
latest_tag="$(jq -r '.tag_name' <<< "$response")"
commit_date="$(jq -r '.created_at' <<< "$response")"

prefetch_output="$(nix-prefetch-github --rev "$latest_tag" ${owner} ${repo})"
commit_sha="$(jq -r '.rev' <<< "$prefetch_output")"
source_hash="$(jq -r '.hash' <<< "$prefetch_output")"

nixfile="$(nix-instantiate --eval -E "with import ./. {}; (builtins.unsafeGetAttrPos \"version\" ${pname}).file" | tr -d '"')"
sed -i "$nixfile" \
  -e "s|version = \".*\";|version = \"''${latest_tag#v}\";|" \
  -e "s|commitSha = \".*\";|commitSha = \"$commit_sha\";|" \
  -e "s|commitDate = \".*\";|commitDate = \"$commit_date\";|" \
  -e "s|hash = \"sha256-.*\";|hash = \"$source_hash\";|"
''

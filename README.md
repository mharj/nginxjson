# nginxjson

Docker Nginx/alpine image with JSON env transformation script.

This image will read environment variables and write them to a JSON as template file. (only for keys which exists on JSON file).

This is useful for dynamic (fetch/axios loading) "env" configuration for UI applications wihtout having to rebuild the image for different environments.

## Script ENV variables

- `STATIC_PATH` - OPTIONAL - Path to static files (defaults: `/usr/share/nginx/html`).
- `SETTINGS_FILE` - REQUIRED - JSON file which will be transformed with ENV data.(if not exists, just passes through).

## Examples

__config.json__ on root folder (i.e. on React public folder)

```json
{
  "API_BASE": null  // or some other default value
}
```

```bash
docker run -e SETTINGS_FILE=config.json -e API_BASE=https://some.prod.server/api mharj/nginxjson
```

example compose / stack file

```yaml
version: "3"
services:
  frontend:
    image: mharj/nginxjson
    ports:
      - 11435:80
    environment:
      SETTINGS_FILE: config.json
      API_BASE: https://some.prod.server/api
```

## Output example from Docker startup.
```
...
...
checking env variables in /usr/share/nginx/html/config.json
==> API_BASE = https://some.prod.server/api
/usr/share/nginx/html/config.json variables
{
  "API_BASE": "https://some.prod.server/api"
}
...
...
```
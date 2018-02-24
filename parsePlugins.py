import json

f = open('plugins.json')
lines = f.read()
f.close()

plugins = json.loads(lines)
plugins = plugins['plugins']

pluginList = {}

for plugin in plugins:
    if plugin['active']:
        pluginList[plugin['shortName']] = plugin['version']

f = open('plugins.txt', 'a+')

for plugin in pluginList:
    f.write('{0}:{1}\n'.format(plugin, pluginList[plugin]))

f.close()
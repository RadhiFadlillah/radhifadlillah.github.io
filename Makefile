CSS_DIR = themes/geos2/css
LESS_DIR = themes/geos2/less

BROWSER_LIST = last 2 versions, > 8%
LESS_FLAGS = --strict-imports --clean-css --autoprefix="$(BROWSER_LIST)"

serve:
	@boom serve .

less-bundle:
	@npx lessc $(LESS_FLAGS) "$(LESS_DIR)/index.less" "$(CSS_DIR)/index.css"

install-npm:
	@npm install esbuild less less-plugin-autoprefix less-plugin-clean-css --save-dev
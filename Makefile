# personal hugo commands set
.OS_TYPE	:= $(shell uname -s)
post :=
note :=

default:
ifneq ("${post}", "")
	@$(MAKE) new post='${post}'
else ifneq ("${note}", "")
	@$(MAKE) new note='${note}'
else
	@$(MAKE) server
endif

new:
ifneq ("${post}", "")
	hugo new 'note/${post}.md'
else ifneq ("${note}", "")
	hugo new 'note/${note}.md'
else
	@echo please set a TITLE for new article
	@exit 1
endif

server:
ifeq ("${.OS_TYPE}", "Darwin")
	open http://localhost:1313 &>/dev/null
endif
ifeq ("${.OS_TYPE}", "Linux")
	xdg-open http://localhost:1313 &>/dev/null
endif
	hugo server --disableFastRender --buildDrafts

push:
	git add .
	git commit -m '$(shell date)'
	git push

publish:
	hugo --cleanDestinationDir --gc

all: build

build:
	docker build -t seigeweapon/yocto-build .

run:
	docker run -it seigeweapon/yocto-build

deploy:
	docker push seigeweapon/yocto-build

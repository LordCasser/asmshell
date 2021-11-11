.DEFAULT_GOAL := build
ALL_TARGETS := unicorn keystone capstone asmshell
.PHONY: clean ${ALL_TARGETS}

all: ${ALL_TARGETS}

clean:
	-rm ./asmshell
	-cd ./deps;rm -rf unicorn keystone capstone
	-rm -rf ./deps/install/*

build: all


OS := $(shell uname -s)
ARCH := $(shell uname -m)
export C_INCLUDE_PATH=$(PWD)/deps/install/include
export CPLUS_INCLUDE_PATH=$(PWD)/deps/install/include
export CGO_LDFLAGS=-L$(PWD)/deps/install/lib -lunicorn -lkeystone -lcapstone -lm

unicorn:
	cd deps && [ ! -e unicorn ] && \
	proxychains4 git clone https://github.com/unicorn-engine/unicorn.git && git --git-dir unicorn fetch; \
	cd unicorn && git clean -fdx && git reset --hard origin/master; \
	mkdir build && cd build && \
	cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=../../install -DBUILD_SHARED_LIBS=OFF .. && \
	make -j && make install

keystone:
	-cd deps && [ ! -e keystone ] && \
	proxychains4 git clone https://github.com/keystone-engine/keystone.git && git --git-dir keystone pull; \
	cd keystone; git clean -fdx && git reset --hard origin/master; mkdir build && cd build && \
	cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=../../install -DBUILD_SHARED_LIBS=OFF .. && \
	make -j && make install; \
	rm ../../install/lib/libkeystone.so

capstone:
	-cd deps && [ ! -e capstone ] && \
	proxychains4 git clone https://github.com/aquynh/capstone.git; \
	cd capstone && git checkout 4.0.2 && git clean -fdx && mkdir build && cd build && \
	cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=../../install -DBUILD_SHARED_LIBS=OFF .. && \
	make -j && make install; \
	rm ../../install/lib/libcapstone.so*



GOBUILD := go build

asmshell:
	@echo "$(GOBUILD) -o asmshell"
	@sh -c "$(GOBUILD) -o asmshell"
	@echo "Generate 'asmshell'"

IGNORE_DEPS += edown eper eunit_formatters meck node_package rebar_lock_deps_plugin rebar_vsn_plugin reltool_util
C_SRC_DIR = /path/do/not/exist
C_SRC_TYPE = rebar
DRV_CFLAGS = -fPIC
export DRV_CFLAGS
ERLANG_ARCH = 64
export ERLANG_ARCH
ERLC_OPTS = +debug_info
export ERLC_OPTS
ERLC_OPTS += -Dnamespaced_types=1

DEPS += idna
dep_idna = hex 1.2.0 idna
DEPS += mimerl
dep_mimerl = hex 1.0.2 mimerl
DEPS += certifi
dep_certifi = hex 0.7.0 certifi
DEPS += metrics
dep_metrics = hex 1.0.1 metrics
DEPS += ssl_verify_fun
dep_ssl_verify_fun = hex 1.1.1 ssl_verify_fun


rebar_dep: preprocess pre-deps deps pre-app app

preprocess::

pre-deps::

pre-app::

include $(if $(ERLANG_MK_FILENAME),$(ERLANG_MK_FILENAME),erlang.mk)
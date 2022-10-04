# ======================================================= #

CORE_FILE = adder.core
VENDOR	= e4tham
LIBRARY	= verilog_template
CORE	= adder
VERSION	= 1.0.0
PROJECT = ${VENDOR}:${LIBRARY}:${CORE}:${VERSION}

RTL = $(shell find rtl -type f)
SIM = $(shell find sim -type f)

# VVP Dump
DUMP = build/${VENDOR}_${LIBRARY}_${CORE}_${VERSION}/sim-icarus/dump.fst

# Usage
USAGE_REPORT = build/${VENDOR}_${LIBRARY}_${CORE}_${VERSION}/usage-yosys/usage.txt


# ======================================================= #

.PHONY: init build sim view lint usage clean

# ======================================================= #
# Targets

init: fusesoc.conf

build: fusesoc.conf ${RTL}
	fusesoc run --build --target sim ${PROJECT}

sim: fusesoc.conf ${RTL}
	fusesoc run --target sim ${PROJECT}

view: fusesoc.conf ${DUMP}
	gtkwave ${DUMP} > /dev/null 2>&1 &

lint: fusesoc.conf ${RTL}
	fusesoc run --target lint ${PROJECT}

usage: ${USAGE_REPORT}

clean:
	rm -rf build fusesoc.conf

# ======================================================= #
# Files

fusesoc.conf: ${CORE_FILE}
	rm -f fusesoc.conf
	fusesoc library add ${VENDOR}_${LIBRARY}_${CORE}_${VERSION} . --sync-type=local

${DUMP}: ${SIM} fusesoc.conf ${RTL} ${CORE_FILE}
	fusesoc run --target sim ${PROJECT}

${USAGE_REPORT}: ${CORE_FILE} fusesoc.conf ${RTL} usage.tcl
	fusesoc run --target usage ${PROJECT}

# ======================================================= #

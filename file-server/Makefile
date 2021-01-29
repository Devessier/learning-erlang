ERLC = erlc
SRCS = $(wildcard *.erl)
TARGETS = $(SRCS:%.erl=%.beam)

%.beam: %.erl
	$(ERLC) -W -b beam $(EFLAGS) $<

all: $(TARGETS)

clean:
	\rm -f $(TARGETS)

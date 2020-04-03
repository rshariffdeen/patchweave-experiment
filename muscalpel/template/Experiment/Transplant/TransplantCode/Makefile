CFLAGS = -I ../Host/cflow-1.4/gnu/ -I ../Host/cflow-1.4/src/

CHECKPACKAGE = `pkg-config --cflags --libs check`

Individual.x:	main.o InterfaceWithCoreFeature.o
	gcc -std=gnu99 -o Individual.x main.o InterfaceWithCoreFeature.o -lm $(CHECKPACKAGE) $(CFLAGS)

main.o:	main.c
	gcc -std=gnu99 -c -o main.o main.c $(CFLAGS)

InterfaceWithCoreFeature.o:	InterfaceHeader.h InterfaceWithCoreFeature.c
	gcc -std=gnu99 -c -o InterfaceWithCoreFeature.o InterfaceWithCoreFeature.c $(CFLAGS)


CD := cd

lower = \
	$(subst A,a,$(1)) \
	$(subst B,b,$(1)) \
	$(subst C,c,$(1)) \
	$(subst D,d,$(1)) \
	$(subst E,e,$(1)) \
	$(subst F,f,$(1)) \
	$(subst G,g,$(1)) \
	$(subst H,h,$(1)) \
	$(subst I,i,$(1)) \
	$(subst J,j,$(1)) \
	$(subst K,k,$(1)) \
	$(subst L,l,$(1)) \
	$(subst M,m,$(1)) \
	$(subst N,n,$(1)) \
	$(subst O,o,$(1)) \
	$(subst P,p,$(1)) \
	$(subst Q,q,$(1)) \
	$(subst R,r,$(1)) \
	$(subst S,s,$(1)) \
	$(subst T,t,$(1)) \
	$(subst U,u,$(1)) \
	$(subst V,v,$(1)) \
	$(subst W,w,$(1)) \
	$(subst X,x,$(1)) \
	$(subst Y,y,$(1)) \
	$(subst Z,z,$(1))

upper = \
	$(subst a,A,$(1)) \
	$(subst b,B,$(1)) \
	$(subst c,C,$(1)) \
	$(subst d,D,$(1)) \
	$(subst e,E,$(1)) \
	$(subst f,F,$(1)) \
	$(subst g,G,$(1)) \
	$(subst h,H,$(1)) \
	$(subst i,I,$(1)) \
	$(subst j,J,$(1)) \
	$(subst k,K,$(1)) \
	$(subst l,L,$(1)) \
	$(subst m,M,$(1)) \
	$(subst n,N,$(1)) \
	$(subst o,O,$(1)) \
	$(subst p,P,$(1)) \
	$(subst q,Q,$(1)) \
	$(subst r,R,$(1)) \
	$(subst s,S,$(1)) \
	$(subst t,T,$(1)) \
	$(subst u,U,$(1)) \
	$(subst v,V,$(1)) \
	$(subst w,W,$(1)) \
	$(subst x,X,$(1)) \
	$(subst y,Y,$(1)) \
	$(subst z,Z,$(1))

targets := Anal1 Anal2 CAnal DM PhyMed

dirs = \
	$(foreach \
		name, \
		$(targets), \
		$(shell $(CD) $(call lower,$(name)) & $(MAKE) $(name)$(1) & $(CD) ..)\
	)

$(foreach \
	target, \
	$(targets), \
	$(eval $(target)% : ; $(CD) $(call lower,$(target)) & $(MAKE) $* & $(CD) ..) \
)

all :
	$(call dirs,_all)

colour :
	$(call dirs,_colour)

bw :
	$(call dirs,_bw)

Anal1% :
	$(CD) anal1 & $(MAKE) $* & $(CD) ..

bw_% :
	$(call dirs,_bw.$*)

% :
	$(call dirs,.$*)

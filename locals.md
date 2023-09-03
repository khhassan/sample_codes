```do
**************************************************

ssc install listutil

local cty 112 132 134 136 156 158 111

 di  `cty'
112132134136156158111

 di  "`cty'"
112 132 134 136 156 158 111

local ncty = `r(nw)'

di `ncty' 
7

rotlist `cty', rot(-1)

local now `r(list)'

di "`now'"
111 112 132 134 136 156 158

takelist `now',pos(2)

local dep `r(list)'

 di `dep'
112

**************************************************

```

Library for aiding lua development in Stormworks  
Set library name to "JumperLib"  
  
Mostly intended for personal use, so there may be:
- None or lacking documentation
- Niche use cases or methods
- Inconsistant definitions
- Function name or its arguments/return value may be changed
  
Also due to Stormworks char limit of 4096 per script then code structure that reduces overall char amount is mostly prefered, which may sacrifice readability, but speed is prefered over reducing char.  
Or I just write bad code in general :P  
General things I have in mind when writing or alike to reduce char:
- Will use long and hopefully descriptive variable names and let the minifier do its job.
- More inlined code as in tenary operations or instead of splitting calculations up in more variables or functions then it will be in a single dense var assignment. More likely to comment to compensate the sacrificed readability.  
- If local is used multiple times in a scope, then there will be a single dense multiple local assignment.
- I prefer table reuse, reduce and recycle. This is done for speed by reducing garbage collector and dynamic/heap allocation overhead, but coding structure will take more chars and boilerplate code.
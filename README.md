# hackNY Pokédex

Input [hackNY](http://hackny.org) fellows, outputs the corresponding Pokémon.

Currently includes fellows from 2010-2014. 147 alumni. We'll be entering Johto soon. 

version 1.0.0 built and presented at [hackNY Spring 2015](http://hackny-s2015.challengepost.com/), March 7-8th at Columbia University

An online Pokédex will be coming soon!

--

### magikarp.rb

don't underestimate it

Methodology:

- Scrapes the hackNY cohort announcement blog posts from hackNY.org, using [nokogiri](http://www.nokogiri.org/)
- Alphabetizes each cohort by fellow's first name
- Creates a master hackNY fellow object with name, university (based on info in the blog's table)
- Uses fellow's index to match with the corresponding Pokémon number, using [pokéapi](http://pokeapi.co/)

This is my first time writing Ruby code. Any suggestions on how to evolve `magikarp.rb` to `gyarados.rb` are greatly appreciated.
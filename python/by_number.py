
import sys

import data

num = int(sys.argv[1])


for pokemon in data.pokemon:
    if pokemon['number'] == num:
        print "{0} has number {1} and max combat power {2}".format(pokemon['name'], pokemon['number'], pokemon['max_cp'])

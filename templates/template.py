#!/usr/bin/env python

"""A simple python script template.

"""

import os
import sys
import argparse


def main(arguments):
    parser = argparse.ArgumentParser(description=__doc__)

    parser.add_argument('infile', help="Input file", type=argparse.FileType('r'))
    parser.add_argument('infiles', metavar='tabfile', nargs='+',
                        help='multiple input files')    
    parser.add_argument("-r", "--required",
                        required="True",
                        dest="variable",
                        help="required variable")
    parser.add_argument("--aflag",
                        action = "store_false",
                        dest="a_flag",
                        help="flag")
    parser.add_argument('-o', '--outfile', help="Output file",
                        default=sys.stdout, type=argparse.FileType('w'))

    args = parser.parse_args(arguments)

    print args
    
if __name__ == '__main__':
    sys.exit(main(sys.argv[1:]))

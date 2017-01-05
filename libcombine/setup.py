#! /usr/bin/env python

from setuptools import setup

setup(name='libcombinex',
      version='0.1.0',
      description='A library for working with COMBINE archives',
      author='Frank Bergmann, Kyle Medley (packaging)',
      url='https://github.com/sbmlteam/libCombine',
      packages=['libcombine'],
      package_data={'libcombine': ['*.so*','*.dylib*','lib*']})

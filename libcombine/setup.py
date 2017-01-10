#! /usr/bin/env python

from setuptools import setup

setup(name='tecombine',
      version='0.2.0',
      description='A library for working with COMBINE archives',
      author='Frank Bergmann, Kyle Medley (packaging)',
      url='https://github.com/sbmlteam/libCombine',
      packages=['tecombine'],
      package_data={'tecombine': ['*.so*','*.dylib*','lib*']})

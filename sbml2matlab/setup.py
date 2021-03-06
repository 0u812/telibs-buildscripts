#!/usr/bin/env python

from setuptools import setup

setup(name='sbml2matlab',
      version='0.9.1',
      description='An SBML to MATLAB translator',
      author='Stanley Gu, Lucian Smith',
      author_email='stanleygu@gmail.com, lucianoelsmitho@gmail.com',
      url='https://github.com/stanleygu/sbml2matlab',
      packages=['sbml2matlab'],
      package_data={
          # add dll, won't hurt unix, not there anyway
          "sbml2matlab": ["_sbml2matlab.pyd", "*.dll", "*.txt",
                          "*.lib", "*.so*", "*.dylib*"]
      })

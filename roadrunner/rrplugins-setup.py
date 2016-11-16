#!/usr/bin/env python

from setuptools import setup

setup(name='rrplugins',
    author='J Kyle Medley, M T Karlsson, Herbert M Sauro',
    author_email='tellurium-discuss@u.washington.edu',
    version='1.1.4',
    description='Plugins for libroadrunner',
    url='http://libroadrunner.org',
    packages=['rrplugins'],
    package_dir={
        'rrplugins' : 'site-packages/rrplugins',
    },
    install_requires=['libroadrunner>=1.4.10', 'matplotlib>=1.5'],
)

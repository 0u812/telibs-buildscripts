#!/usr/bin/env python

from setuptools import setup

setup(name='libroadrunner',
    author='J Kyle Medley, M T Karlsson, Herbert M Sauro',
    author_email='tellurium-discuss@u.washington.edu',
    version='0.1.0',
    description='Plugins for libroadrunner',
    url='http://libroadrunner.org',
    packages=['rrplugins'],
    package_dir={
        'rrplugins' : 'site-packages/rrplugins',
    },
    install_requires=['roadrunner>=1.4.9'],
)

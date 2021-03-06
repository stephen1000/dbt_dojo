""" Project Setup """

import setuptools

with open("readme.md", "r") as f:
    long_description = f.read()

dev_req = [
    "black>=19.10b0",
    "pylint>=2.5.3",
]

test_req = [
    "pytest>=5.4.3",
]

setuptools.setup(
    name="dbt_demo",
    version="0.0.1",
    author="Stephen Lowery",
    author_email="author@example.com",
    description="Code used for a dbt learning dojo",
    long_description=long_description,
    long_description_content_type="text/markdown",
    url="",
    package_dir={"": "src"},
    install_requires=[
        "python-dotenv>=0.13.0",
        "dbt==0.17.1",
    ] + dev_req,
    extras_require={"dev": test_req + dev_req, "test": test_req,},
    packages=setuptools.find_packages("src"),
    classifiers=[
        "Programming Language :: Python :: 3",
        "License :: OSI Approved :: MIT License",
        "Operating System :: OS Independent",
    ],
    python_requires=">=3.6",
)
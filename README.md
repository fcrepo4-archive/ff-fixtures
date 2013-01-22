# Fedora Futures Fixtures

This repository is a collection of digital objects that the Fedora Futures project uses to exercise the "Fedora 4" implementation, and compare it to other repository implementations.

Objects are stored in the ```objects``` directory. Each directory represents a unique digital object. The unique identifer for an object is the directory name. Object directories are a BagIt-style bag.


## Python

Install bagit client
```bash
$ pip install bagit
```

Bag it
```bash
$ mkdir objects/my-unique-identifier
# put content in the directory
$ bagit.py --contact-name 'Your Name' objects/my-unique-identifier
```

Add it to git

```bash
$ git add -A objects/my-unique-identifier
$ git commit -m "Adding a new object"
$ git push origin master
```

## Random test data set
The set is created by the script https://github.com/futures/ff-fixtures/blob/master/create_random_files.sh which writes the files to objects/random and creates the necessary manifest.txt file used by the JMeter Tests at https://github.com/futures/ff-jmeter-madness

It works by using some standard GNU commands including dd, rm and iterates over a list of integer filesizes in https://github.com/futures/ff-fixtures/blob/master/random_sizes.data in order to create one file per iteration of the given size in megabytes. This to a certain extend ensures the comparability of the measurements, since exactly the same number of files with the same number of bytes is created each time the data set is generated with the same input file.

run the script:
```bash
./create_random_data.sh
```

this will create the directory objects/random and, using dd, create the random binaries as objects/random/random_N.data.

Additionally a file manifest.txt is generated which is employed by the JMeter tests to find the random binaries for uploading them via HTTP requests

There is also a file https://github.com/futures/ff-fixtures/blob/master/random_sizes_reduced.data, which is another smaller smaple set (7.9GB) for use in smaller scale environments (e.g. my laptop ;)

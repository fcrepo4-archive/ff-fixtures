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
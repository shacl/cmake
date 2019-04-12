### Git Submodules 101 ###

#### Basics #####

Git submodules are effectingly a reference from one Git repository to a
particular state of another Git repository. This is reference is represented
in Git using

+ a commit hash
+ a relative directory path
+ a remote uniform resource identifier (URI)
+ (optionally) an associated branch

Here, a URI can be

+ an http/https address
+ an ssh address
+ a file address
+ a relative address

In the case of a relative address, Git internally computes an absolute address
for the submodule as needed. This is done by taking the submodule url to be
relative to a remote url. By default, the remote considered in the remote
associated with the current branch of the repository in which submodule resides.
In the case that current branch has no associated remote, `origin` is used
instead.

> Relative URI's can very useful when working with a project leveraging a
> modular repository structure. Here, by modular structure, I mean a project
> which version controls individual components in separate repositories, which
> express interdependencies using git submodules. Using relative URI's for
> (at least) intra-project dependencies allows a project to migrate (or mirror)
> from one repository hosting platform (let's say Atlassian's bitbucket) to
> another platform (say Microsoft's Github) without modifying the submodule
> URIs.

#### Adding New Submodules ####

Git submodules are relatively painless to incorporate into a Git reposotory.
Here we consider a simple example adding three submodules. To begin let's
create a empty repository.

```
mkdir repo
cd repo
git init
git remote add origin ssh://git@xcp-stash.lanl.gov:7999/project/repo.git
```

We'll begin simply. Our first submodule will be Keith O'Hara's
[excellent constexpr math library](https://github.com/kthohr/gcem.git).

```
git submodule add https://github.com/kthohr/gcem.git
```

This submodule is

+ associated with the current commit at the HEAD of the repository default
branch (master).
+ cloned into the `gcem` relative directory
+ using an https address referring to Github as a URI
+ not associated with any branch

------

Our second submodule will be Phil Nash's
[excellent unit testing library](https://github.com/catchorg/Catch2.git).
This time, we'll associate the submodule with a branch and explicitly specify
a relative directory.

```
git submodule add -b master              \
  https://github.com/catchorg/Catch2.git \
  dependencies/Catch2
```

Note the addition of the `-b` argument. This flag indicates that the submodule
should track a branch (in this case, `master`). To summarize, this submodule

+ associated with the current commit at the HEAD of master.
+ cloned into the `dependencies/Catch2` relative directory
+ using an https address referring to Github as a URI
+ is associated with the `Catch2` master branch

-----

Our last submodule will be Niels Lohmann's
[excellent JSON library](https://github.com/nlohmann/json.git).
In this case, in addition to explicitly specifying a relative directory, we'll
use a relative URI.

```
git submodule add ../../nlohmann/json.git dependencies/nlohmann_json
```

For this clone, this relative URI will be resolved against our demonstration
repostiory's orgin remote URI, i.e.
`ssh://git@xcp-stash.lanl.gov:7999/nlohmann/json.git`.

> Note that the time of writing a mirror of Lohmann's library is maintained on
> the ADLX bitbucket instance.

This submodule is

+ associated with the current commit at the HEAD of the repository default
branch (master).
+ cloned into the `dependencies/nlohmann_json` relative directory
+ using a relative URI
+ not associated with any branch


#### Inspecting the Submodule State #####

In any Git repository hosting submodules, in the highest level directory of the
repository, there should exist a `.gitmodules` file. Consider the following
example extracted from the `shacl::cmake` testing repository:

```
[submodule "dependencies/Catch2"]
	path = dependencies/Catch2
	url = https://github.com/catchorg/Catch2.git
	branch = master
[submodule "dependencies/nlohmann_json"]
	path = dependencies/nlohmann_json
	url = ../../nlohmann/json.git
```

Here we see two submodules. By default submodules are named by using their
respective relative path in the parent repository. There are a number of nested
fields (`path`, `url`, and `branch`) which correspond to components of the
submodule state. Note that, in this example, the `Catch2` submodule has an
associated branch (`master`) while the `nlohmann_json` submodule does not.

Perceptive readers may have noticed that in the example `.gitmodules` file,
there is no field which corresponds the the associated commit hash for for
either submodule. This is not an oversight; the associated commit hash is not
stored in this file!

The commit hash can be obtained a few ways. A simple way to query the associated
hash would be to intialize the submodule and query the result repository. Using
Catch2 as an example:

```
git submodule update --init -- dependencies/Catch2
cd dependencies/Catch2
git rev-parse HEAD
```

Sometimes it's useful to query this information without actually initializing
the submodule (e.g. the network is unavailable or the submodule is
time-consuming to clone). Surely we can query the parent repository? This is
information is in fact stored in the parent repository and, we do have access to
it. The submodule commit hash is stored as the index entry associated with the
submodule directory. Taking Catch2 for example:

```
git ls-tree HEAD dependencies/Catch2
```

As of the time of writing, on the `shacl::cmake` testing repository, this
command has the following output:

```
160000 commit 60b05b20413afe4ad9980e627862474a9b8ba4cd	dependencies/Catch2
```

The third field in the output (`60b05b204`...) is the commit hash tracked by
the Catch2 module.


#### Updating Submodules ####

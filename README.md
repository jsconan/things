# things

Some 3D printing purpose things

<!-- vscode-markdown-toc -->

-   [At a glance](#Ataglance)
-   [Install and requirements](#Installandrequirements)
    -   [OpenSCAD](#OpenSCAD)
    -   [Source code](#Sourcecode)
        -   [Download the zip file](#Downloadthezipfile)
        -   [Get the code from the repository](#Getthecodefromtherepository)
-   [Render the parts](#Rendertheparts)

<!-- vscode-markdown-toc-config
	numbering=false
	autoSave=true
	/vscode-markdown-toc-config -->
<!-- /vscode-markdown-toc -->

## <a name='Ataglance'></a>At a glance

The project contains designs for various purposes. The parts are designed using a scripting language, processed by [OpenSCAD](https://openscad.org/about.html). There is no ready to use 3D model files in the source code. If you are interested in such files, please look at the [released versions](https://github.com/jsconan/things/releases) which contains 3D model files built with default parameters. However, if you want to customize these parts, tailoring them with your measures, you should rather download the source code and then tweak the configuration files before generating your own 3D model files.

## <a name='Installandrequirements'></a>Install and requirements

To properly use the project you first need to do some installations steps.

### <a name='OpenSCAD'></a>OpenSCAD

First of all you need [OpenSCAD](https://openscad.org/) to be installed. To do so, please go to the [OpenSCAD download page](https://openscad.org/downloads.html), an get the version suitable for your operating system.

### <a name='Sourcecode'></a>Source code

The source code is hosted on a [Git](https://git-scm.com/) repository. To get it you can either download a [zip file](https://github.com/jsconan/things/archive/refs/heads/main.zip), or clone the repository locally.

Note: the easiest way is to call the `init.sh` script, that will take care of this for you.

#### <a name='Downloadthezipfile'></a>Download the zip file

The source code can be downloaded from the [GitHub repository](https://github.com/jsconan/things).

You can download it as zip file from this [link](https://github.com/jsconan/things/archive/refs/heads/main.zip).

As the project is using a shared library, that is not supplied with the package, you will need to also download it.

Download the zip file from this [link](https://github.com/jsconan/camelSCAD/archive/refs/heads/main.zip).

Then extract its content inside the folder `lib/camelSCAD`. Please make sure the folder directly contains the library and not an intermediate folder like `lib/camelSCAD/camelSCAD-master`. If this is the case, please move the content one folder up and delete the extra folder.

#### <a name='Getthecodefromtherepository'></a>Get the code from the repository

A git tool is needed if you intend to get the source code from the git repository. You can download one either from the [main git website](https://git-scm.com/downloads), or from [GitHub](https://docs.github.com/en/github-cli).

Once you have your git tool installed, open a console window, select a project folder (create it if needed), then run the following commands:

```
git clone https://github.com/jsconan/things.git
cd things
git submodule init
git submodule update
```

The source code should have been downloaded, as well as the libraries.

Note: you can also use a graphical interface tool. In this case, please make it can also install the submodules.

## <a name='Rendertheparts'></a>Render the parts

The parts are all located into the `parts` folder. They can all be opened separately in [OpenSCAD](https://openscad.org/) and rendered.

However, it is possible to render all parts in batch. The script `render.sh` takes care of this.

This is a command-line tool, which accept several parameters. By default, it will render the preset selected in the config.

It is possible to select another preset, as well as set a different number of cells for the containers.

The parameter `-h` make it show the help.

Running the command `render.sh -h` will show this message:

```
Renders OpenSCAD files
  Usage:
	./render.sh [command] [-h|--help] [-o|--option value] files

  -h,  --help         Show this help
  -d   --dir          Select a particular parts directory to render
  -f   --format       Set the output format
  -p   --parallel     Set the number of parallel processes
  -c   --clean        Clean up the output folder before rendering
```

The STL files are rendered to the `dist` folder.

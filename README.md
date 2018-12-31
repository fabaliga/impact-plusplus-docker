# Impact-PlusPlus-Docker

This project provides docker tooling to develop, build and deploy Impact projects.
It also contains a merge of both [Impact](https://impactjs.com/) and [ImpactPlusPlus](http://collinhover.github.io/impactplusplus/).

### Prerequisites

In order to develop, build and deploy Impact projects, both docker and docker-compose are required.

On MacOS, you can install docker and docker-compose using brew:

```
brew install docker
brew install docker-compose
```

additionally, in order to deploy, an AWS S3 bucket is required.

## Project Source Merge

The source includes a functional merge of both [Impact source](https://github.com/phoboslab/Impact) and [ImpactPlusPlus source](https://github.com/collinhover/impactplusplus).

The merge has been achieved using the following recipe:

```
# clone both Impact and ImpactPlusPlus repositories
git clone https://github.com/phoboslab/Impact
git clone https://github.com/collinhover/impactplusplus

# merge Impact with ImpactPlusPlus sources
cp -R impactplusplus/lib Impact
cp -R impactplusplus/media Impact

# modify **lib/game/main.js** to add plusplus dependency and to change inherited class to GameExtended
# modify **lib/plusplus/config-user.js** with GAME_WIDTH_VIEW, GAME_HEIGHT_VIEW and TOP_DOWN values
```

## Project Docker Tooling

Impact docker tooling can be found in the **tools** directory. All commands should be executed from there.

```
cd tools
```

A tool called **impact-cli.sh** allows to perform the devops steps.

### Develop

Developing Impact projects requires a static content delivery server and a PHP server.
Using an Apache/PHP docker image, the following commands allow to develop locally and to test using `http://localhost:8000/` (port can be changed in **tools/dev.yml** file).

To start the development environment

```
./impact-cli.sh dev-start
```

To stop the development environment

```
./impact-cli.sh dev-stop
```

### Build

To build the distribution, a PHP environment is required.
Using the previous Apache/PHP docker image, the following command allows to populate a dist folder with minified js, and to update the **index.html** file with appropriate js links (new **build.sh** script is in charge of the global process).

To create the dist folder

```
./impact-cli.sh build
```

### Deploy

To deploy the distribution folder to a S3 server, the user must edit the **deploy.yml** file and fill three environment variables (**AWS_ACCESS_KEY_ID**, **AWS_SECRET_ACCESS_KEY**, **AWS_DEFAULT_REGION**) as well as the **BUCKET_NAME** in the last line of the file (s3 sync command line).

To deploy the dist folder to the AWS S3 bucket

```
./impact-cli.sh deploy
```

Notes about AWS configuration:

> The IAM user mapped to the AWS_ACCESS_KEY_ID must have RW rights on the bucket.
> The bucket public access settings (permissions tab) must not block public access.
> The bucket policy (permissions tab) must allow the IAM user mapped to the AWS_ACCESS_KEY_ID to ListBucket, GetBucketLocation, RW on the bucket, and allow read for everyone.
> The bucket must have Static Web Hosting configured (Properties tab).
> Optionally, Route53 can be used to bind a domain name with the Static Web Hosting bucket.

## Built With

* [VSCode](https://code.visualstudio.com/) - Open source IDE
* [Docker](https://www.docker.com/) - Containerization platform

## Authors

* **Dominic Szablewski** - Impact Engine - [phoboslab](https://github.com/phoboslab)
* **Collin Hover** - Impact++ Extension - [collinhover](https://github.com/collinhover)
* **Fabien Baligand** - Devops Tooling - [fabaliga](https://github.com/fabaliga)

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
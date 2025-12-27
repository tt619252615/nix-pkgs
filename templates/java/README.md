# Java Development Environment

## Quick Start

```bash
# Enter development shell
nix develop

# Check Java version
java --version

# Run Java file
java Main.java

# Or compile and run
javac Main.java
java Main
```

## Project Setup

### Maven Project

```bash
mvn archetype:generate -DgroupId=com.example -DartifactId=myapp -DarchetypeArtifactId=maven-archetype-quickstart -DinteractiveMode=false
cd myapp
mvn package
java -jar target/myapp-1.0-SNAPSHOT.jar
```

### Gradle Project

```bash
gradle init --type java-application
./gradlew build
./gradlew run
```

## Changing JDK Version

Edit `nix/development.nix`:

```nix
{ mkShell, jdk17, maven, gradle, fish, writeText }:  # Change jdk21 to jdk17

# ...

packages = [
  jdk17  # Change here too
  # ...
];

shellHook = ''
  export JAVA_HOME=${jdk17}  # And here
  # ...
'';
```

Available JDKs: `jdk8`, `jdk11`, `jdk17`, `jdk21`

## Adding Build Tools

Edit `nix/development.nix`:

```nix
packages = [
  jdk21
  fish
  maven
  gradle
  # Add more tools here
  ant
  kotlin
  scala
  visualvm
];
```

## Adding System Dependencies

```nix
packages = [
  # ... existing

  # For JavaFX
  openjfx

  # For native libraries
  gcc
  zlib
];
```

## Customizing Shell Theme

Edit the `fishConfig` section in `nix/development.nix`:

```nix
# Change colors
set -g fish_color_command red --bold
set -g fish_color_param bryellow

# Change prompt icon
set_color red; echo -n " $java_version"  # Change  to other icon
```

## Using with direnv

Create `.envrc`:

```bash
use flake
```

Then:

```bash
direnv allow
```

## Environment Variables

Set automatically:

- `JAVA_HOME` - Points to JDK
- `M2_HOME` - Maven home (`$PWD/.m2`)
- `GRADLE_USER_HOME` - Gradle home (`$PWD/.gradle`)

To customize:

```nix
shellHook = ''
  export MAVEN_OPTS="-Xmx2g"
  export GRADLE_OPTS="-Xmx2g"
  # ...
'';
```

## IDE Integration

### IntelliJ IDEA

Point to Nix JDK:

```bash
echo $JAVA_HOME
# Use this path in IntelliJ SDK settings
```

### VS Code

Install "Language Support for Java" extension, it will detect the JDK automatically.

## Project Structure

```
.
├── flake.nix           # Flake entry point
├── flake.lock          # Locked dependencies
├── nix/
│   └── development.nix # Shell configuration
├── pom.xml             # Maven config (or build.gradle)
├── src/
│   └── main/java/
└── README.md
```

## Common Issues

### JAVA_HOME not set

Ensure `JAVA_HOME` is exported in `shellHook`:

```nix
shellHook = ''
  export JAVA_HOME=${jdk21}
  # ...
'';
```

### Maven/Gradle download issues (China)

Add mirror configuration:

```bash
# Maven: edit ~/.m2/settings.xml
# Gradle: edit gradle.properties
```

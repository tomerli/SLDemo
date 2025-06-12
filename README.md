# Swan Station Protocol (Java)


![Swan](/docs/screenshot.png?raw=true)

In the TV series [Lost](https://en.wikipedia.org/wiki/Lost_(TV_series)), the residents of the Swan station [followed a protocol](https://lostpedia.fandom.com/wiki/Pushing_the_button) that required them to input a specific sequence into a computer every 108 minutes. By entering these numbers and pressing "execute" (commonly referred to as pushing the button), they would release an electromagnetic buildup, thereby continuously preventing a global disaster.

This repository is a playful tribute to that protocol, designed to create a dummy mechanism that, although non-functional, still operates. 

* The objective is to generate rolling functions on an hourly basis, adding a new function file every hour that must be tested by an automated system. 
* Since this application will also serve as a demo for Test Impact Analysis (Test Optimization), the test recommendation system will likely suggest skipping the first 23 files, as they were already tested in the previous automation cycle.

```ascii
+---------------------------+     +-----------------------------+     +------------------------------+     +-----------------------------+     +----------------------------------------+  
| Generate Rolling          | --> | Add New Function File       | --> | Automated System Tests       | --> | Test Impact Analysis        | --> | Recommend Tests: Skip First 23 Files   |  
| Functions (Hourly)        |     | (Every Hour)                |     |                              |     | (Test Optimization)         |     | (Already Tested in Previous Cycle)     |  
+---------------------------+     +-----------------------------+     +------------------------------+     +-----------------------------+     +----------------------------------------+  
```

## Building and Running the Application

### Prerequisites
- Java 17 or higher
- Maven 3.6 or higher

### Build the Application
```bash
./gradlew clean build
```

### Run the Application
```bash
./gradlew bootRun
```

### Running Tests
```bash
./gradlew test
```

## Local Debugging & SeaLights Java Agent

Before running the instrumented app, make sure to set the following important environment variables:

> Note that the SeaLights agent is particular about environment variables, and they are case-sensitive!

```bash
export SL_TOKEN="$(cat sltoken.txt)"
export SL_BUILD_SESSION_ID="<build-session-id>"
export SL_LOG_LEVEL="debug"
```

Then run the application with the SeaLights agent:

```bash
# Option 1: Configure agent via JAVA_TOOL_OPTIONS (Recommended for bootRun)
export JAVA_TOOL_OPTIONS="-javaagent:./sealights-agent.jar" 
./gradlew bootRun 

# Option 2: Run the built JAR directly (Ensure you build first: ./gradlew build)
# java -javaagent:./sealights-agent.jar -jar build/libs/swan-station-*.jar 
```

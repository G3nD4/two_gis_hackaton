
allprojects {
    repositories {
        google()
        mavenCentral()
        maven {
            // Kotlin DSL requires using uri(...) and assigning to 'url'
            url = uri("https://artifactory.2gis.dev/sdk-maven-release")
        }
    }
}

val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}

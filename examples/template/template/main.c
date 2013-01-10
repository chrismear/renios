#include "SDL.h"
#include <python2.7/Python.h>

#include "Helpers.h"

int main(int argc, char *argv[])
{
    int ret = 0;
    
    RENIOS_SetSaveDirectoryEnv();
    printf("RENIOS_SAVE_DIRECTORY: %s", getenv("RENIOS_SAVE_DIRECTORY"));
    
    size_t scriptsPathSize = 1024;
    const char *scriptsPath = malloc(scriptsPathSize);
    // FIXME: Buffer overflow if path > 1024 bytes
    scriptsPath = RENIOS_CopyGameDirectoryToLibraryIfNecessary();
    if (!scriptsPath) {
        return 1;
    }
    
    // Get current working directory, which is the app root,
    // and also the bundle root.
    size_t cwdSize = 512;
    char *cwd = malloc(cwdSize);
    if (getcwd(cwd, cwdSize) == cwd) {
        printf("cwd: %s", cwd);
    } else {
        return 1;
    }
    
    const char *launcherFilename = "launcher";
    
    char *launcherRelativePath = "/launcher.py";
    char *launcherAbsolutePath = malloc(strlen(scriptsPath) + strlen(launcherRelativePath) + 1);
    strncpy(launcherAbsolutePath, scriptsPath, strlen(scriptsPath) + 1);
    strncat(launcherAbsolutePath, launcherRelativePath, strlen(launcherRelativePath) + 1);
    printf("launcherAbsolutePath: %s", launcherAbsolutePath);
    
    
    FILE *launcherFile = fopen(launcherAbsolutePath, "r");
    if (launcherFile == NULL) {
        printf("Couldn't open script file.");
    }
    
    //    setenv("RENPY_SCALE_FACTOR", "2", 1);
    
    Py_SetProgramName(cwd);
    
    Py_SetPythonHome(cwd);
    
    Py_Initialize();
    
    // Set sys.argv for Python, which the Ren'Py launcher uses to locate
    // the Ren'Py 'base' directory.
    char **pythonArgv = malloc(sizeof(char *));
    *pythonArgv = launcherAbsolutePath;
    PySys_SetArgv(1, pythonArgv);
    
    PyEval_InitThreads();
    
    
    printf("Running Python code.");
    ret = PyRun_SimpleFile(launcherFile, launcherFilename);
    if (ret == 0) {
        printf("Python run was successful.");
    } else {
        printf("Python run raised exception.");
    }
    
    
    Py_Finalize();
    
    
    free(launcherAbsolutePath);
    free(cwd);
    free(scriptsPath);
    return ret;
}

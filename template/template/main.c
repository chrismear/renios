/*
 * Copyright 2012, 2013 Chris Mear <chris@feedmechocolate.com>
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the
 * "Software"), to deal in the Software without restriction, including
 * without limitation the rights to use, copy, modify, merge, publish,
 * distribute, sublicense, and/or sell copies of the Software, and to permit
 * persons to whom the Software is furnished to do so, subject to the
 * following conditions:
 *
 * The above copyright notice and this permission notice shall be included
 * in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
 * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN
 * NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
 * DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
 * OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE
 * USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

#include "SDL.h"
#include "python2.7/Python.h"

#include "Helpers.h"

int main(int argc, char *argv[])
{
    int ret = 0;

    RENIOS_SetSaveDirectoryEnv();
    printf("RENIOS_SAVE_DIRECTORY: %s", getenv("RENIOS_SAVE_DIRECTORY"));

    size_t scriptsPathSize = 1024;
    const char *scriptsPath = malloc(scriptsPathSize);
    scriptsPath = RENIOS_ScriptsPath();

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

    setenv("RENPY_RENDERER", "gl", 1);
    setenv("RENPY_GL_ENVIRON", "shader_es", 1);
    setenv("RENPY_GL_RTT", "fbo", 1);
    
    setenv("RENPY_VARIANT", RENIOS_ScreenVariant(), 1);

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

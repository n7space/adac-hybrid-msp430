#include <stdint.h>
#include <stdbool.h>

// Reporting functions defined in Ada "Reporting" module
void reporting__init();
void reporting__reportsuccess();
void reporting__reporterror(const int32_t errno);

// Tested function defined in a bodyless Ada module
int32_t functionInHeader(const int32_t a);

static bool test_functionInHeader()
{
    const int32_t a = 15;
    const int32_t result = functionInHeader(a);
    if (result == (a * a) + 1)
        return true;
    return false;
}

void runTests(void)
{
    reporting__init();
    if (!test_functionInHeader())
    {
        reporting__reporterror(0);
        return;
    }
    reporting__reportsuccess();
}

int main(void)
{
    runTests();
    for (;;);
    return 0;
}
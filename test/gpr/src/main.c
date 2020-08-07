#include <stdint.h>

// Test function defined in Ada "AdaModule" module
int32_t addInt32(const int32_t a, const int32_t b);

// Reporting functions defined in Ada "Reporting" module
void reporting__init();
void reporting__reportsuccess();
void reporting__reporterror(const int32_t errno);

int main()
{
    reporting__init();
    const int32_t a = 64;
    const int32_t b = 17;
    const int32_t result = addInt32(a, b);
    if (result == a + b)
        reporting__reportsuccess();
    else
        reporting__reporterror(0);
    return 0;
}
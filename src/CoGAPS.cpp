#include "Rpackage/src/GapsRunner.h"

#include <string>

#include <cstdlib>
#include <cstdio>
#include <getopt.h>

int main(int argc, char** argv)
{
    // internal parameters    
    std::string data;
    unsigned nPatterns = 7;
    unsigned nIterations = 1000;
    unsigned nCores = 1;
    unsigned seed = 0;
    std::string outFile("cogaps_result");

    // names of allowed parameters
    const char *short_opt = "d:p:i:c:s:o:h";
    struct option long_opt[] =
    {
        {"data",          required_argument, NULL, 'd'},
        {"nPatterns",     required_argument, NULL, 'p'},
        {"nIterations",   required_argument, NULL, 'i'},
        {"nCores",        required_argument, NULL, 'c'},
        {"seed",          required_argument, NULL, 's'},
        {"outFile",       required_argument, NULL, 'o'},
        {"help",          no_argument,       NULL, 'h'},
        {NULL,            0,                 NULL,  0 }
    };

    // parse command line
    int c = 0;
    while ((c = getopt_long(argc, argv, short_opt, long_opt, NULL)) != -1)
    {
        switch(c)
        {
            case -1: // no more arguments
            case 0:  // long options toggles
                break;
            case 'd':
                data = optarg;
                break;
            case 'p':
                nPatterns = atoi(optarg);
                break;
            case 'i':
                nIterations = atoi(optarg);
                break;
            case 'c':
                nCores = atoi(optarg);
                break;
            case 's':
                seed = atoi(optarg);
                break;
            case 'o':
                outFile = optarg;
                break;
            case 'h':
                printf("Usage: %s [OPTIONS]\n", argv[0]);
                printf("  -d, --data file         count matrix file\n");
                printf("  -p, --nPatterns N       number of patterns\n");
                printf("  -i, --nIterations N     max number of iterations\n");
                printf("  -c, --nCores N          max number of cores to use\n");
                printf("  -s, --seed N            random generator seed\n");
                printf("  -o, --output file       output file name\n");
                printf("  -h, --help              print this help message\n");
                printf("\n");
                return 0;

            case ':':
            case '?':
                fprintf(stderr, "Try `%s --help' for more information.\n", argv[0]);
                return -1;

            default:
                fprintf(stderr, "%s: invalid option -- %c\n", argv[0], c);
                fprintf(stderr, "Try `%s --help' for more information.\n", argv[0]);
                return -1;
        };
    }

    // required parameters
    if (data.empty())
    {
        fprintf(stderr, "no data file provided\n");
        fprintf(stderr, "Try `%s --help' for more information.\n", argv[0]);
        return -1;
    }

    // run cogaps
    GapsParameters params(data, false, false, false, std::vector<unsigned>());
    params.nPatterns = nPatterns;
    params.nIterations = nIterations;
    params.maxThreads = nCores;
    GapsRandomState randState(seed);
    GapsResult result(gaps::run(data, params, std::string(), &randState));
    return 0;
}
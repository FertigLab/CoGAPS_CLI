#include "Rpackage/src/GapsDispatcher.h"

#include <boost/program_options.hpp>

#include <iostream>
#include <string>

namespace po = boost::program_options;

int main(int argc, char* argv[])
{
    po::options_description desc("Allowed options");
    desc.add_options()
        ("help", "produce help message")
        ("data", po::value<std::string>(), "path to data matrix")
        ("numPatterns", po::value<unsigned>()->default_value(3), "number of patterns to fit")
        ("seed", po::value<uint32_t>()->default_value(0), "seed for random number generator")
        ("outFile", po::value<std::string>()->default_value("cogaps_result"), "name of output file")
        ("nCores", po::value<unsigned>()->default_value(1), "number of cores to run on")
    ;

    po::variables_map vm;
    po::store(po::parse_command_line(argc, argv, desc), vm);
    po::notify(vm); 

    if (vm.count("help"))
    {
        std::cout << desc << "\n";
        return 0;
    }
    else if (!vm.count("data"))
    {
        std::cout << "No data file provided\n";
        return -1;
    }

    GapsDispatcher dispatcher(vm["seed"].as<uint32_t>());
    dispatcher.setNumPatterns(vm["numPatterns"].as<unsigned>());
    dispatcher.setNumCoresPerSet(vm["nCores"].as<unsigned>());
    dispatcher.loadData(vm["data"].as<std::string>());
    GapsResult result(dispatcher.run());
    //result.writeCsv(vm["outFile"].as<std::string>());

    return 0;
}
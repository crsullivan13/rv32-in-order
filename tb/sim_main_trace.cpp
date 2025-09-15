#include "Vcore.h"
#include "verilated.h"
#include "verilated_vcd_c.h"

#include <memory>

int main(int argc, char** argv) {
    const std::unique_ptr<VerilatedContext> contextp {new VerilatedContext};
    contextp->commandArgs(argc, argv);
    const std::unique_ptr<Vcore> top {new Vcore};

    Verilated::traceEverOn(true);
    VerilatedVcdC* tfp = new VerilatedVcdC;
    top->trace(tfp, 99);
    tfp->open("dump.vcd");

    while ( !Verilated::gotFinish() && contextp->time() < 20 ) {
        top->clock = contextp->time() & 1;
        top->reset = ( contextp->time() < 6 );
        top->eval();

        printf("Cycle %llu: PC=%u\n", contextp->time() / 2, top->pc);
        contextp->timeInc(1);
        tfp->dump(contextp->time());
    }
    tfp->close();
    delete tfp;

    return 0;
}
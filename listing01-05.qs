//////////////////////////////////////
// Listing 1: Einfaches Q#-Programm //
//////////////////////////////////////

namespace QuantumSample {
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Measurement;

    operation MeasureSuperposition() : Result {
        use q = Qubit();
        H(q);
        return MResetZ(q);
    }


////////////////////////////////////////////////////////////////
// Listing 2: Aufruf einer Q#-Operation aus einem C#-Programm //
////////////////////////////////////////////////////////////////

using Microsoft.Quantum.Simulation.Core;
using Microsoft.Quantum.Simulation.Simulators;
using QuantumSample;
using var sim = new QuantumSimulator();
var MeasureResult = await MeasureSuperposition.Run(sim);


////////////////////////////////////////////////////////////////////
// Listing 3: Aufruf einer Q#-Operation aus einem Python-Programm //
////////////////////////////////////////////////////////////////////

import qsharp
from QuantumSample import MeasureSuperposition
measure_result = MeasureSuperposition.simulate()


//////////////////////////////////////////////
// Listing 4: Zufallszahl mit Q# generieren //
//////////////////////////////////////////////

namespace QuantumSample {
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Intrinsic;
    
    operation MeasureSuperposition() : Result {
        use q = Qubit();
        H(q);
        return MResetZ(q);
    }

    @EntryPoint()
    operation QuantumRandom(max : Int) : Int {
        mutable sample = 0;
        repeat {
            mutable bits = [];
            for i in 1..BitSizeI(max) {
                set bits += [MeasureSuperposition()];
            }
            set sample = ResultArrayAsInt(bits);
        } until (sample <= max);
         Message($"Generiere Zufallszahl zwischen 0 und {max}: ");
         return sample;
    }
}


///////////////////////////////////////////////////////
// Listing 5: Operation mit spezialisierten Bloecken //
///////////////////////////////////////////////////////

operation Op (q : Qubit) : Unit is Adj + Ctl { 
body (...) {

    <Anweisungen>
    }
adjoint (...) { 
    <Anweisungen>
    }
controlled (cs, ...) {
    <Anweisungen> 
    } 
}
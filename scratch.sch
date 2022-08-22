v {xschem version=3.0.0 file_version=1.2 }
G {}
K {}
V {}
S {}
E {}
C {code.sym} 10 -70 0 0 {name=commands only_toplevel=false value="
.options savecurrents


.option
.control
save all
let startR = 20k
let endR = 30k
let incre = 1k
let curR = startR
while curR le endR
alter Rt curR
dc temp -40 100 1
write dc.out Vbg
set appendwrite
let curR = curR + incre
end
run

plot dc1.Vbg dc2.Vbg dc3.Vbg dc4.Vbg dc5.Vbg dc6.Vbg dc7.Vbg dc8.Vbg dc9.Vbg dc10.Vbg


.endc

*** plot voltage coefficient
*Vdd VDD GND 3.3
*V_en en GND 3.3
*.dc Vdd 2 4 0.1
*.control
*run
*plot deriv(V(Vbgp))
*.endc

*** plot temperature coefficient
*Vdd VDD GND 3.3
*V_en en GND 3.3
*.dc temp -40 140 1
*.control
*run
*plot deriv(V(Vbgp))/1.202344
*.endc



*** enable pin
*Vdd VDD GND 3.3
*V_en en GND PULSE(0 3.3 0 200us 200us 600us 2000us 0)
*.tran 1u 2000us
*.control
*run
*plot V(en)
*plot -I(VDD)
*.endc
"}
C {devices/code_shown.sym} 830 -1130 0 0 {name=NGSPICE1
only_toplevel=true
spice_ignore=false
value="
.option savecurrents
.option warn=1
.param VDD=1.8
.param R3val='22.187k'
.param alpha='1'
.param R2R3ratio='5.6555038*alpha'
.param R2val='R3val*R2R3ratio' 
.param R4R2ratio=0.79694273
.param R4val='R2val*R4R2ratio'
.nodeset v(vgate)=1.3
.option temp=0
.dc temp -40 100 1
.control
save all
*+ @m.xm13.msky130_fd_pr__pfet_01v8_lvt[gm]
*+ @m.xm3.msky130_fd_pr__pfet_01v8_lvt[gm]
*+ @m.xm4.msky130_fd_pr__pfet_01v8_lvt[gm]
*+ @m.xm5.msky130_fd_pr__nfet_01v8_lvt[gm]
*+ @m.xm6.msky130_fd_pr__nfet_01v8_lvt[gm]
*+ @m.xm7.msky130_fd_pr__nfet_01v8_lvt[gm]
*+ @m.xm8.msky130_fd_pr__pfet_01v8_lvt[gm]
*+ @m.xm9.msky130_fd_pr__nfet_01v8_lvt[gm]
run
plot Vbg
plot deriv(Vbg)
plot vota_bias
let i_bias = vmbias#branch
plot i_bias
*plot vbg vfeedback vcurrent_gate
let i_left = vm1#branch
let i_right = vm2#branch
let i_3 = vm3#branch
plot i_left i_right i_3
plot i_3
plot deriv(i_3)
plot va vb vbe3 vgate
plot Veb vbneg
plot vbe3
plot deriv(vbe3)
let iout = vm3#branch
let iref = vm4#branch
let iref_final = vm5#branch
*plot iout iref iref_final
*plot iref iref_final
*plot deriv(iout) deriv(iref) deriv(iref_final)
*plot vcurrent_gate vd5 vd4
save vbg deriv(vbg)


let indx27 = 3700
let indx0 = 1000
let indx70 = 8000
*indx is the index of temperature sweep for 27degC
echo 'Vbg @ 27degC'
let vbg27c = vbg[indx27]
print vbg27c
echo 'dVbe/degC & ppm @ 27degC'
print deriv(vbg)[indx27] deriv(vbg)[indx27]/vbg27c
echo 'ppm real'
print (vbg[indx70]-vbg[indx0])/vbg[indx27]/(70-0)*1e6
*plot deriv(vbg)/vbg27c
*plot v(va, vb) vs i
*plot vm1#branch vm2#branch vm3#branch
save deriv(vbg)/vbg27c
let vsg = vdd - vgate
let vsd1 = vdd - va
let vsd2 = vdd - vb
let vsd3 = vdd - vbg
*let vthp = @m.xm1.msky130_fd_pr__pfet_01v8_lvt['vth']
*let vov = vsg - vthp
**plot vov vsd1 vsd2 vsd3
*let deltav = vb - vbneg
*let r4 =vbg/vm3#branch
*let r1 =va/vr1#branch
*let r2 =vb/vr4#branch
*let r3 =deltav/vr2#branch
*let vptat =(r2/r3*deltav)
*let sum = veb+vptat
**plot veb vptat sum
**plot deriv(veb) deriv(vptat)
*save veb vptat sum deriv(veb) deriv(vptat)
*let gm1=@m.xm1.msky130_fd_pr__pfet_01v8_lvt[gm]
*let gm2=@m.xm2.msky130_fd_pr__pfet_01v8_lvt[gm]
*let Av2=gm2 * ((r3 + r3/ln(39)) * r2 / (r3 + r3/ln(39) + r2) )
*let Av1=gm1 * (r1 * r3/ln(39))/(r1 + r3/ln(39))
**plot Av1 Av2 Av2/Av1
*let gm13=@m.xm13.msky130_fd_pr__pfet_01v8_lvt[gm]
*let gm3=@m.xm3.msky130_fd_pr__pfet_01v8_lvt[gm]
*let gm4=@m.xm4.msky130_fd_pr__pfet_01v8_lvt[gm]
*let gm5=@m.xm5.msky130_fd_pr__nfet_01v8_lvt[gm]
*let gm6=@m.xm6.msky130_fd_pr__nfet_01v8_lvt[gm]
*let gm7=@m.xm7.msky130_fd_pr__nfet_01v8_lvt[gm]
*let gm8=@m.xm8.msky130_fd_pr__pfet_01v8_lvt[gm]
*let gm9=@m.xm9.msky130_fd_pr__nfet_01v8_lvt[gm]
*let vdsat1=2/(gm1/vm1#branch)
*let vdsat2=2/(gm2/vm2#branch)
*let vdsat3=2/(gm3/vm3#branch)
*let vdsat4=2/(gm4/@m.xm4.msky130_fd_pr__pfet_01v8_lvt[id])
*let vdsat5=2/(gm5/@m.xm5.msky130_fd_pr__nfet_01v8_lvt[id])
*let vdsat6=2/(gm6/@m.xm6.msky130_fd_pr__nfet_01v8_lvt[id])
*let vdsat7=2/(gm7/@m.xm7.msky130_fd_pr__nfet_01v8_lvt[id])
*let vdsat8=2/(gm8/@m.xm8.msky130_fd_pr__pfet_01v8_lvt[id])
*let vdsat9=2/(gm9/@m.xm9.msky130_fd_pr__nfet_01v8_lvt[id])
*let vdsat13=2/(gm13/@m.xm13.msky130_fd_pr__pfet_01v8_lvt[id])
*save (vdd-va-vdsat1) (vdd-vb-vdsat2) (vdd-vbg-vdsat3)
*+ (vdd-vgate-vdsat4) (vgate-vq-vdsat5) (vq-0-vdsat6)
*+ (vx-0-vdsat7) (vdd-vg-vdsat8) (vg-vq-vdsat9) (vdd-vx-vdsat13)

unset askquit
*quit
.endc
" }
C {sky130_fd_pr/res_high_po.sym} -180 -270 0 0 {name=R4
W=2
L=46
model=res_high_po
spiceprefix=X
mult=1}
C {code.sym} 10 310 0 0 {name=commands_param_sweep only_toplevel=false value="
.options savecurrents

*** plot temperature coefficient
*Vdd VDD GND 3.3
*V_en en GND 3.3
*.dc temp -40 140 1
.control
*run
*dc temp -40 100 1
*plot Vout

save all
set appendwrite
compose width_vector  values 1.25 2
compose length_vector values 0.15 1

let i = 0 
while i < length(width_vector)
    reset
    echo 'assigning vectors'
    alter @m.xm1.msky130_fd_pr__nfet_01v8[L] = length_vector[i]
    echo 'Still assigning vectors'
    alter @m.xm1.msky130_fd_pr__nfet_01v8[W] = width_vector[i]
    echo 'done assigning'
    dc temp -40 100 1
    plot Vout
    
    let i = i + 1 
end


.endc



*** plot voltage coefficient
*Vdd VDD GND 3.3
*V_en en GND 3.3
*.dc Vdd 2 4 0.1
*.control
*run
*plot deriv(V(Vbgp))
*.endc

*** plot temperature coefficient
*Vdd VDD GND 3.3
*V_en en GND 3.3
*.dc temp -40 140 1
*.control
*run
*plot deriv(V(Vbgp))/1.202344
*.endc



*** enable pin
*Vdd VDD GND 3.3
*V_en en GND PULSE(0 3.3 0 200us 200us 600us 2000us 0)
*.tran 1u 2000us
*.control
*run
*plot V(en)
*plot -I(VDD)
*.endc
"}
C {code.sym} 300 120 0 0 {name=commands_plain_temp_sweep only_toplevel=false value="
.options savecurrents

*** plot temperature coefficient
*Vdd VDD GND 3.3
*V_en en GND 3.3
*.dc temp -40 140 1
.control
save all
run
dc temp -40 100 1
plot Vbg




.endc



*** plot voltage coefficient
*Vdd VDD GND 3.3
*V_en en GND 3.3
*.dc Vdd 2 4 0.1
*.control
*run
*plot deriv(V(Vbgp))
*.endc

*** plot temperature coefficient
*Vdd VDD GND 3.3
*V_en en GND 3.3
*.dc temp -40 140 1
*.control
*run
*plot deriv(V(Vbgp))/1.202344
*.endc



*** enable pin
*Vdd VDD GND 3.3
*V_en en GND PULSE(0 3.3 0 200us 200us 600us 2000us 0)
*.tran 1u 2000us
*.control
*run
*plot V(en)
*plot -I(VDD)
*.endc
"}
C {devices/code_shown.sym} -740 -310 0 0 {name=NGSPICE2
only_toplevel=true
spice_ignore=false
value="
.option savecurrents
.option warn=1
.nodeset v(vgate)=1.3
.option temp=0
.dc temp -20 100 1
.control
save all

run
plot Vbg
plot deriv(Vbg)

let i_left = vm1#branch
let i_right = vm2#branch
let i_3 = vm3#branch

let iout = vm3#branch
let iref = vm4#branch
let iref_final = vm5#branch

plot iref iref_final
plot deriv(iref) deriv(iref_final)

save vbg deriv(vbg)




unset askquit
*quit
.endc
" }
C {devices/code_shown.sym} -1120 210 0 0 {name=NGSPICE4
only_toplevel=true
spice_ignore=false
value="
.option savecurrents
.option warn=1
.nodeset v(vgate)=1.3
.option temp=0
.dc temp -20 100 1
.control
save all

run
plot Vbg
plot deriv(Vbg)
plot Vota_bias1

let i_left = vm1#branch
let i_right = vm2#branch
let i_3 = vm3#branch

let iout = vm3#branch
let iref = vm4#branch
let iref_final = vm5#branch

plot iref iref_final
plot deriv(iref) deriv(iref_final)

save vbg deriv(vbg)




unset askquit
*quit
.endc
" }
C {devices/code_shown.sym} -1520 190 0 0 {name=NGSPICE3
only_toplevel=true
spice_ignore=false
value="
.option savecurrents
.option warn=1
.nodeset v(vgate)=1.3
.option temp=0
.dc temp -20 100 1
.control
save all

run
plot Vbg
plot deriv(Vbg)
plot Vota_bias1
plot vd4 vd5 vcurrent_gate

let i_left = vm1#branch
let i_right = vm2#branch
let i_3 = vm3#branch

let iout = vm3#branch
let iref = vm4#branch
let iref_final = vm5#branch

plot iref iref_final
plot deriv(iref) deriv(iref_final)

save vbg deriv(vbg)




unset askquit
*quit
.endc
" }
C {devices/code_shown.sym} -270 -50 0 0 {name=s2 
only_toplevel=true 
spice_ignore=false

value="
.option savecurrents

.param VDD=1.8
.control
save all

run
option temp=27
tran 0.1n 20u
plot VDD Vbg porst
plot porst_buff
plot vm5#branch

unset askquit

.endc
"}

---
layout: default
title: Electricity
---

# 电学

电是一种能量形式，它的表现形式是电荷的流动。电荷有两种：正电荷和负电荷。大多数电现象都是由于电子（带负电荷的粒子）在物体中移动而产生的。电子的移动会形成电流，而电流则是电的基本表现形式之一。

**电压（Voltage）**

电压是推动电流在电路中流动的“压力”或“势能差”。电压的单位是伏特（V），用符号“V”表示。电压越大，电流流动的动力越强。

+ `+` Positive 正极
+ `-` Negative 负极

**电流（Current）**

电流是电荷在电路中流动的速率。电流的单位是安培（A），用符号“I”表示。电流的方向通常定义为正电荷流动的方向（尽管实际是电子在反方向移动）。

**电阻（Resistance）**

电阻是对电流流动的阻碍，单位是欧姆（Ω）。电阻越大，电流通过的难度越高。电阻通常由电路中的各种元件提供，帮助调节电流。

## 电路类型

一个简单的电路通常包括一个电源（比如电池）、导线和一个负载（比如灯泡）。电源提供电压，导线连接电路元件，负载消耗电能。电流在闭合电路中流动，形成电能的传输。

- **串联电路**：电流依次流过每个元件，如果一个元件失效，整个电路就会中断。
- **并联电路**：每个元件都有独立的路径，如果一个元件失效，其他元件仍然可以工作。

### 电源

+ AC 交流电
+ DC 直流电

> [!WARNING]
> 在进行电路设计时，务必注意电压和电流的安全性。高电压和高电流可能会对人体造成伤害。

### 电阻器（Resistor）

电阻器是一种消耗电能并提供电阻的元件，用于限制电流流动。电阻的大小决定了它对电流的阻碍作用。可以用欧姆定律（V = IR）来计算电阻、电流和电压的关系。

![](https://cdn.shopify.com/s/files/1/0262/6564/9240/files/hnhResistor.png)

### 电容器（Capacitor）

电容器是一种储存电荷的元件。电容器可以暂时储存电能，并在需要时释放。电容的单位是法拉（F），它决定了电容器储存电荷的能力。

![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjYvIWtAho9oKmhJR2NdbZD-A7z9CNJ7SWZabnr97r50BhoLnOFYwT5c-rubAoidhDmTE2w72hEdvImg7G-HGzwVjJeBmT4I7MKUVrN9OvfT247VznUPg0E7Ed23dpiTTQjnnS38O25KBPC/s1600/capacitor-symbols.jpg)

### 电感器（Inductor）

电感器是由线圈绕成的元件，用于储存磁能。电感器会对电流的变化产生阻碍作用，特别是在交流电路中。电感的单位是亨利（H）。

![](https://madpcb.com/wp-content/uploads/2020/11/Inductor.jpg)

### 二极管（Diode）

二极管是一种只能让电流单向流动的元件。它常用于整流电路中，将交流电转换为直流电。

![](https://etechsparks.com/wp-content/uploads/2023/11/diode-symboll.png)

### 晶体管（Transistor）

三极管，全称应为半导体三极管，也称双极型晶体管、晶体三极管，是一种控制电流的半导体器件。其作用是把微弱信号放大成幅度值较大的电信号，也用作无触点开关。

三极管是在一块半导体基片上制作两个相距很近的 PN 结，两个 PN 结把整块半导体分成三部分，中间部分是基区，两侧部分是发射区和集电区，排列方式有 PNP 和 NPN 两种。

它有三极：

+ **B**ase 基极
+ **E**mitter 发射极
+ **C**ollector 集电极

晶体三极管（以下简称三极管）按材料分有两种：锗管和硅管。而每一种又有NPN和PNP两种结构形式

![](https://static.mianbaoban-assets.eet-china.com/2020/3/aey6Bn.jpeg)

但使用最多的是 硅NPN 和 锗PNP 两种三极管，（其中，N是负极的意思（代表英文中Negative）

N型半导体在高纯度硅中加入磷取代一些硅原子，在电压刺激下产生自由电子导电，而P是正极的意思（Positive）是加入硼取代硅，产生大量空穴利于导电）。

![](https://docs.oldtimes.me/c.biancheng.net/cpp/uploads/allimg/140316/1-1403161PR6491.png)

两者除了电源极性不同外，其工作原理都是相同的

**箭头朝内 PNP，导通电压顺箭头过，电压导通，电流控制。**

![](https://docs.oldtimes.me/c.biancheng.net/cpp/uploads/allimg/140316/1-1403161Q024S5.png)

三极管基极通过一个 10K 的电阻接到了单片机的一个 IO口上，假定是 P1.0，发射极直接接到 5V 的电源上，集电极接了一个 LED 小灯，并且串联了一个 1K 的限流电阻最终接到了电源负极 GND 上。

放大倍率

#### NPN型

#### PNP型

### 电压计
### 电流计
### 功率计

### 继电器
### 接触器
### 空气开关
### 漏电保护器

### 芯片（Chip）

有些芯片具有可编程特性，如 STC80C51、STM32、[ESP8266、ESP32](./espressif) 等。

### 电源系统

+ [ASM1117](./asm1117)
+ [ME????]()
+ TP4056

电池充放电电路

### Common Designator Meanings

| Designator | Component type |
|---|---|
| A | Separable assembly, Sub-assembly (e.g. printed circuit assembly) |
| AN, AS | Antenna |
| AR | Amplifier |
| AT | Attenuator, Isolator |
| BR | Bridge rectifier |
| B, BT | Battery |
| BZ | Buzzer |
| C | Capacitor |
| CB | Circuit breaker, Supercapacitor |
| CN | Capacitor network |
| D, | CR Diode (all types, including LED), Thyristor |
| DL | Delay line |
| DS | Display, General light source, Lamp, Signal light |
| F | Fuse |
| FB | Ferrite bead |
| FD | Fiducial |
| FL | Filter |
| G | Generator, Oscillator |
| GN | General network |
| H | Hardware, Screws, Nuts, Washers |
| HY | Circulator, Directional coupler |
| IR | Infrared diode |
| J | Jack (least-movable connector of a connector pair), Jack connector (connector may have male pin contacts and/or female socket contacts) |
| JP | Jumper (Link) |
| K | Relay, Contactor |
| L | Inductor, Coil, Ferrite bead |
| LS | Loudspeaker, Buzzer |
| M | Mosfet, Motor, Meter, Measuring device |
| MH | Mounting hole |
| MK | Microphone |
| MP | Mechanical part (including screws and fasteners) |
| OP | Opto-isolator, Operational amplifier |
| P | Plug (most-movable connector of a connector pair), Plug connector (connector may have male pin contacts and/or female socket contacts) |
| PS | Power supply |
| Q | Transistor (all types) |
| R | Resistor |
| RLA, RY | Relay |
| RN | Resistor network |
| RT | Thermistor |
| RV | Varistor, Variable resistor |
| S, SW | Switch (all types, including buttons) |
| T | Transformer, Incorrectly used as transistor (see “Q”) |
| TC | Thermocouple |
| TP | Test point |
| TR | Transistor, Transducer |
| TUN | Tuner |
| U | Integrated circuit (IC), Inseparable assembly |
| V | Vacuum tube |
| VR | Voltage regulator (voltage reference), Variable resistor (potentiometer or rheostat), PTC |
| W | Cable, Wire, Busbar |
| X | Socket connector for another item not P or J, paired with the letter symbol for that item (XV for vacuum tube socket, XF for fuse holder, XA for printed circuit assembly connector, XU for integrated circuit connector, XDS for light socket, etc.) |
| XMER | Transformer |
| XTAL | Crystal |
| Y | Crystal, Oscillator |
| Z | Zener Diode |

![SMD Cheat Sheet](https://mechaelephant.com/dev/img/smd_cheat_sheet.png)

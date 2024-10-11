---
layout: default
title: Quadcopter
---

# Quadcopter Principles (四轴飞行器原理)

The principle of a quadcopter is straightforward: it can take off as long as it generates enough lift to counteract its own weight. However, the rotation of propellers generates a counter-torque. To neutralize this, helicopters use two or more counter-rotating propellers. Quadcopters achieve greater maneuverability by using at least four rotors that rotate in opposite directions to adjacent ones. For horizontal movement, speed up one pair of adjacent rotors and slow down the opposite pair while maintaining overall lift.

飞行器的原理非常简单，只要产生足够的升力减去自重就可以起飞了。然而，螺旋桨的旋转会产生反扭力。直升机用两个或更多的反向旋转的螺旋桨来消除这一点。四轴飞行器通过使用至少四个螺旋桨来实现更大的机动性，这些螺旋桨与相邻的螺旋桨旋转方向相反。为了水平移动，加速一对相邻的螺旋桨并减慢相对的一对螺旋桨，同时保持总体升力。

## Frame (机架)

The frame of the quadcopter usually comes in an X or cross shape, which look similar but have different forward directions during flight. In theory, as long as the dimensions are symmetrical and the propellers don't clash, the frame is acceptable. A well-known frame model is the DJI F450, which has a wheelbase of 450mm and is made of engineering plastic.

机架通常有X形或十字形两种，这两种外观上看起来相似，但在飞行中前进的方向不同。

理论上，只要尺寸对称并且螺旋桨不会相撞，任何机架都是可以的。

一个比较出名的机架模型是DJI F450，轴距为450mm，由工程塑料制成。

在购买时，你可以选择X模式或+模式，前者更具挑战性但更灵活，后者更易飞但灵活性稍差。

## Propellers (螺旋桨)

![](https://betaflight.com/assets/images/betaflight_props_in_out-704f91537d690070cb896197c62fbcb6.png)

Propellers generally come with a four-digit number. The first two digits represent the diameter of the propeller in inches, and the last two indicate the pitch. They should be installed with the markings facing upwards.

螺旋桨一般带有一个四位数的数字。前两位表示螺旋桨的直径（以英寸为单位），后两位表示螺旋桨的螺距。安装时，标记应该朝上。

## Motors (电机)

Motors for quadcopters are usually brushless for better speed and power efficiency. The naming conventions for motors aren't standardized, but a common method indicates the internal diameter of the external rotor, which provides an idea of the coil diameter and turns.

电机一般分为有刷和无刷两种，但为了获得更高的速度和电力效率，四轴飞行器通常使用无刷电机。电机的命名并没有统一的标准，但比较通用的一种方法是标明电机外转子的内径，这样就能从某种程度上反映出电机的线圈直径和匝数。

## Electronic Speed Controller (ESC) (电子调速器/电调)

The ESC, or Electronic Speed Controller, adjusts the motor's speed according to control signals. It essentially converts the DC battery into a three-phase AC supply for the motor.

电调全称是电子调速器，根据控制信号调节电机的转速。简单来说，电调是将电池的直流电转换为供电机使用的三相交流电。

## Flight Controller (主控制板/飞控)

![](https://opwiki.readthedocs.io/en/latest/_images/CC-top-300.png)

<https://opwiki.readthedocs.io/en/latest/user_manual/cc3d/cc3d.html>

![](https://opwiki.readthedocs.io/en/latest/_images/CC-overall-connections.png)

The flight controller stabilizes the quadcopter using gyroscopes, ensuring it doesn't tumble due to imbalances or other disturbances. When purchasing, you can choose between X-mode and + mode, the former being more challenging but agile, and the latter easier to fly but less flexible.

飞控用陀螺仪稳定四轴飞行器，确保它不会因为各种不平衡或其他干扰而翻滚。

![betaflight](https://github.com/betaflight/betaflight/raw/master/images/bf_logo.png)

<https://github.com/betaflight/betaflight>

## Remote Control (遥控器)

![Flysky i6](https://www.flyskytech.com/u_file/photo/20200226/0680d157bf.jpg)

Remote controls can range from basic to advanced, depending on the brand and model. Prices can also vary considerably, from hundreds to thousands of dollars. A minimum of 4 channels is generally required for effective control.

遥控器的种类多样，从基础到高级，价格也从几百到几千美元不等。通常需要至少4个通道才能有效地控制四轴飞行器。

![](https://github.com/benb0jangles/FlySky-i6-Mod-/blob/master/Images%20for%20readme/i6-firmware-mode-pic.jpg?raw=true)

- 改 8 通道: <https://github.com/benb0jangles/FlySky-i6-Mod->
- 改 14 通道: <https://github.com/qba667/FlySkyI6>

## Battery and Charger (电池和充电器)

Quadcopters usually employ Li-Po batteries for their light weight and high discharge rate. When choosing a battery, make sure to check its 'S' and 'C' ratings to ensure it matches the requirements of the quadcopter.

四轴飞行器通常使用Li-Po电池，因为它们重量轻，放电率高。选择电池时，务必查看其'S'和'C'评级，以确保它符合四轴飞行器的要求。

![](https://www.zoncell.com/uploads/20210405/2021040595257464.jpg)

![](https://ae01.alicdn.com/kf/S6a9346657b754affb927dbb9a87b5f27K.png)
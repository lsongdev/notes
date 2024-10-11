---
layout: default
title: 初次设置
parent: "Voron Design Printer"
nav_order: 4
---

# 初次设置

全部安装好以后首先看下打印机的各个电器部件能否响应，以确保它们能正常工作。

- [Initial Startup Checks](https://docs.vorondesign.com/build/startup)
- [Seahorse](https://seahorse.littlefish.love)

基本流程是:

1. 先看下挤出头和热床能否正常加热，然后进行校准。
2. 看下步进电机能否活动，方向是否正确，然后设置 endstop 以及 homing 归位点。

调试之前先了解一下如何 **「‼️紧急停止」**，因为在调试过程中可能会出现意外情况，及时终止可以避免造成严重的损失，

在 Fluidd 界面右上角或者点一下主控制旋钮下方的小按钮 Klipper 应该关闭。

Fluidd 应该仍在运行，但与 Klipper 断开连接，终端窗口中发送 `FIRMWARE_RESTART` 以使打印机恢复并运行。

## 验证温度

![](https://docs.vorondesign.com/build/startup/images/mainsail_temp_graph.png)

### 热床温度校准

```
PID_CALIBRATE HEATER=heater_bed TARGET=100
```

它将执行持续约 10 分钟的 PID 校准程序。完成后，键入 `SAVE_CONFIG` 将参数保存到您的配置文件中。

### 挤出头温度

```
PID_CALIBRATE HEATER=extruder TARGET=245
```

它将执行持续约 5 分钟的 PID 校准程序。完成后，键入SAVE_CONFIG将参数保存到您的配置文件中。

### 挤出头出料校准

为了确保挤出机挤出正确长度的耗材，只要挤出机与喷嘴发生了变化，重新组装了，都需要校准。

```
rotation_distance = previous_rotation_distance * actual_extrude_distance / 100
```

<style>
  @import url('https://lsong.org/stylesheets/form.css');
  @import url('https://lsong.org/stylesheets/input.css');
</style>
<form id="form" class="form">
  <div class="form-field">
    <label>previous_rotation_distance</label>
    <input name="previous_rotation_distance" type="number" class="input" placeholder="23" required />
  </div>
  <div>
    <label>remain (mm)</label>
    <input name="remain_length" type="number" class="input" placeholder="20" required />
  </div>
  <button type="submit">计算</button>
  <button type="reset">Reset 重置</button>
</form>
<div id="output"></div>
<script>
  const L = 120;
  const $state = {};
  const calc = e => {
    e.preventDefault();
    const { previous_rotation_distance, remain_length } = $state;
    const actual_extrude_distance = L - remain_length;
    const rotation_distance = (previous_rotation_distance * actual_extrude_distance / 100).toFixed(8);
    output.innerHTML = `
      <p>剩余 ${remain_length}mm 耗材，这意味着您实际挤出了 ${actual_extrude_distance}mm 。您的新 <code>rotation_distance</code> 应为 ${rotation_distance}</p>
      <code>rotation_distance: ${rotation_distance}</code>
    `;
  };
  form.addEventListener('input', e => {
    const { name, value } = e.target;
    $state[name] = value;
  });
  form.addEventListener('submit', calc);
</script>

Klipper 重启后，重新按照上面的步骤进行测试，剩余 20mm 表示校准成功。

## 步进电机检查

要验证每个步进电机是否正常运行，请在终端中发送以下命令：

```shell
STEPPER_BUZZ STEPPER=stepper_x
STEPPER_BUZZ STEPPER=stepper_y
STEPPER_BUZZ STEPPER=stepper_z
```

`STEPPER_BUZZ` 命令将使给定步进器沿正方向移动一毫米，然后返回到其起始位置，它将执行此振荡十次。

|步进电机|方向|
|------|------|
| stepper_x | 电机将先顺时针旋转，然后逆时针旋转 |
| stepper_y | 电机将先顺时针旋转，然后逆时针旋转 |
| stepper_z | 床向下移动，然后返回 |

如果完全不动检查 `enable_pin` 和 `step_pin`，如果方向不对 检查下 `dir_pin`，并在前面加一个 `!`。

```yaml
step_pin: X_STEP
dir_pin: !X_DIR
enable_pin: !X_EN
```

## Homing 归位

**XY 归位检查**

```
G28 X
G28 Y
G28 X Y
```

![](https://docs.vorondesign.com/build/startup/images/V0-motor-configuration-guide.png)

**Z 归位检查**

```
Z_ENDSTOP_CALIBRATE
```

```
TESTZ Z=
TESTZ Z=-
TESTZ Z=--
TESTZ Z=++
TESTZ Z=-.1
```

After finding a small amount of friction run the ACCEPT command:

```
ACCEPT
```

## 热床调平

热床调平是3D打印准备过程中至关重要的一步，尤其对新手至关重要。若热床调平不当，打印物可能会粘附不良，或者出现其他打印故障。

**以下简要概述热床调平的通用步骤**：

1. **准备试纸**：一张标准的A4打印纸，用于测量喷嘴与热床之间的间隙。
2. **调整高度**：手动定位打印头至热床一角，然后缓慢旋转该角的调节螺钉，直到感觉到纸与喷嘴之间存在轻微摩擦。应确保不过于紧密或过于松动。
3. **检查所有角落**：逐一移动打印头至热床的其他三个角落，重复上述调整步骤。
4. **核实中心位置**：最后，移动打印头至热床中心，再次使用试纸进行检查。如中心部位与四角高度有明显差异，可能意味着热床已发生弯曲。

V0 采用手动床调平方式。由于该床体积较小且足够厚实，因此无需每次打印时都进行网格或其他类型的调平。在 Klipper 中，有一个专门的宏：BED_SCREWS_ADJUST，用于协助手动调平。

使用此工具时，打印机的喷嘴会被定位到每个螺钉的 XY 位置，并调整到 Z=0.3 的高度。这时，可以使用“试纸法”来微调位于喷嘴正下方的调节螺钉。确切地说，是通过旋转调节螺钉，而非调整喷嘴的高度，直到纸张在滑动时感受到轻微摩擦。完成这一步骤后，必须重新进行Z轴的偏移调整。

![热床调平](https://wiki.bambulab.com/x1/manual/bed-leveling/nozzle_touching_the_print_surface.jpeg)

当你微调螺钉并感受到轻微的摩擦时，你可以选择运行 ACCEPT 或 ADJUSTED 命令。如果需要对调节螺钉进行较大幅度的调整（如超过1/8圈），使用ADJUSTED命令；如果调整微小，就选择ACCEPT命令。不论你选择哪个命令，工具都会自动跳到下一个螺钉。如果需要退出调整流程，可选择使用 ABORT 命令。

当BED_SCREWS_ADJUST命令执行完成后，务必再次运行Z_ENDSTOP_CALIBRATE命令，确保喷嘴处于正确的Z=0位置。

## 测试打印

完成调试后，进行一个小型测试打印，以验证是否一切正常。

1. [Railstops](https://github.com/VoronDesign/Voron-0/blob/Voron0.2r1/STLs/%5Ba%5D_Railstops_x5.stl)
2. [Voron Design Cube](https://github.com/VoronDesign/Voron-2/blob/Voron2.4/STLs/Test_Prints/Voron_Design_Cube_v7.stl)
3. [3D Benchy](https://www.printables.com/model/3161-3d-benchy)

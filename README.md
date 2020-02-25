<h1>brew2</h1>
<h3>Description</h3>

This is a dashboard for brewery control, built using [Node-RED](https://github.com/node-red/node-red) running on a Raspberry Pi.

This dashboard has been specifically developed for, and motivated by [my brewery](https://onbrewing.com). My brewery is a 2 vessel and 1 pump system designed to perform recirculating, full volume mashes. Other homebrewers may find the flows that comprise this dashboard useful in implementing some of the same features in their own brewery controller, but it will likely not suit their needs exactly as is. 

Support for adapting this dashboard to your own brewery/process will be limited. There are many great resources for learning about Node-RED. I've attempted to make flows as readable as possible, and to separate major features into individual flows. 

I am not currently looking for contributors, though I encourage forks of this project, and raising issues to address bugs.

You are free to use my work in whichever way you like, understanding that I accept no liability relating to its use. Please read the license provided. 

<h3>Features</h3>

* Cascade PID temperature control of mash (see below for details)
* Mash PID with output limiting functionality (to protect agaisnt chaotic behaviour and/or scorching of wort in RIMS breweries)
* PID temperature control and manual control options for the boil kettle
* Integrator windup elimination method implemented in all PID algorithms
* Element interlock to ensure only a single element is used at once, and to ensure the RIMS heater can only be activated while the pump is running
* Option of logging of temperature, output, as well as PID calculations (useful for PID tuning and analysing PID behaviour) using [InfluxDB](https://github.com/influxdata/influxdb)
* Logging logic to prevent repeated recording of similar values (change thresholds), and to control logging frequency 
* Looks nice

<h4>Cascade PID</h4>

The Cascade PID algorithm I've implemented in this project is used to dynamically set the temperature Δ between the mash set point and the RIMS heater (or HERMS-coil containing HLT) target temperature. A second PID is then used to control the RIMS heater (or HLT) to this dynamic temperature target. Some of the results of this are as follows:

* During temperature ramps in a step mash, a relatively large temperature Δ will minimize the transition time during mash steps.
* For brewers in non-climate controlled environments, a larger temperature Δ will be used on colder brew days to counter the heightened heat loss in the mash recirculation process, in comparison to warmer brew days.

The temperature Δ range is set to some limits, with the default being [-2°C, 8°C]. The inclusion of a negative temperature delta in this range improves correction abilities for slight overshooting in the mash temperature.

While it is preferred to have accurately calibrated temperature sensors, this cascade PID algorithm also implicitly accounts for calibration differences between mash and RIMS heater temperature sensors should they exist. The mash temperature sensor is the most important one for accuracy.

The default tuning should work for many RIMS breweries. Tuning may be required for HERMS breweries (including counterflow-HERMS). If using a HERMS brewery it is very important to circulate HLT water for effective heat exchange, and to minimize stratification (which will sometimes cause signficant lag in temperature control lopp of the HLT).

If you do not wish to use the Cascade PID functionality, set the outer loop coefficients all to 0. The algorithm will function then as a simple single PID using the inner loop coefficients. This is very useful for tuning the Cascade PID as well. I recommend that you run like this until you find a good tuning for the inner loop, you can then start to increase the outer loop coefficients.

<h4>Logging</h4>

brew2 uses <a href="https://github.com/influxdata/influxdb">InfluxDB</a> for optional logging of temperature and PID calculations. InfluxDB can be installed <a href="https://docs.influxdata.com/influxdb/v1.7/introduction/installation">following instructions here</a>. I recommend running both Node-RED and InfluxDB as services at startup. In my flows I refer to a database called `brew2`. You can create this by connecting to the InfluxDB command line interface (CLI), which can be done by typing simply `influx` after successful installation. Then, in the InfluxDB CLI type `CREATE DATABASE brew2`. You can then `exit`. You may return to this interface to work with your data in various ways - some of the more common operations *may* be implemented directly into brew2 in the future.

<h4>Development...</h3>

* I am currently implementing mash profiles (probably 😜)

<h3>Screenshots (v0.3.1)</h3>

<img src = "main.png" width=600>
<img src = "mash_settings.png" width=600>

<sub>The screenshots included in this repository may not always represent the current version. I will update these screenshots with more significant changes to the dashboard, and will also indicate the version number they represent.</sub>

<h3>License</h3>
<b>MIT License</b>

<i>Copyright (c) 2018-2020 Justin Angevaare</i>

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

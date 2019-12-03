<h1>brew2</h1>
<h3>Description</h3>

This is a dashboard for brewery control, built using [Node-RED](https://github.com/node-red/node-red) running on a Raspberry Pi.

This dashboard is specific to [my brewery](https://onbrewing.com), which is a 2 vessel and 1 pump system designed to perform recirculating, full volume mashes. Other homebrewers may find the flows that comprise this dashboard useful in implementing some of the same features in their own brewery controller, but it will likely not suit their needs exactly as is. I am unable to provide support to anybody in adapting this dashboard to their system, but you are free to use any of my work for your own purposes. Note that the screenshots included in this repository may not always be current!

<h3>Features</h3>
<ul>
<li>Cascade PID temperature control of mash (using RIMS or HERMS), with output limiting functionality</li>
<li>PID temperature control and manual control options of a boil kettle</li>
<li>Element interlock to ensure only a single element is used at once, and to ensure a RIMS only can be activated while pump is running</li>
<li>Option of logging of temperature, output, as well as PID calculations (useful for PID tuning and analysing PID behaviour) using [InfluxDB](https://github.com/influxdata/influxdb).</li>
<li>Looks nice</li>
</ul>

<h3>Important Notes</h3>
<ul>
<li>If you do not wish to use the Cascade PID functionality, set the outer loop coefficients all to 0. The algorithm will function then as a simple single PID using the inner loop coefficients. This is very useful for tuning the Cascade PID as well. I recommend that you run like this until you find a good tuning for the inner loop, you can then start to increase the outer loop coefficients.</li>
<li>brew2 now uses [InfluxDB](https://github.com/influxdata/influxdb). This can be installed [following instructions here](https://docs.influxdata.com/influxdb/v1.7/introduction/installation). I recommend running both Node-RED and InfluxDB as services at startup. In my flows I refer to a database called `brew2`. You can create this by connecting to the InfluxDB command line interface (CLI), which can be done by typing simply `influx` after successful installation. Then, in the InfluxDB CLI type `CREATE DATABASE brew2`. You can then `exit`. You may return to this interface to work with your data in various ways - some of the more common operations *may* be implemented directly into brew2 in the future.</li>
</ul>

<h3>Screenshots (v0.3.1)</h3>
<img src = "main.png" width=600>
<img src = "mash_settings.png" width=600>

<h3>License</h3>
<b>MIT License</b>

<i>Copyright (c) 2018-2019 Justin Angevaare</i>

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

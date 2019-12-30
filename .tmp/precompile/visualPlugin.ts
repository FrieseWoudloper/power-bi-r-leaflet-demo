import { Visual } from "../../src/visual";
import powerbiVisualsApi from "powerbi-visuals-api"
import IVisualPlugin = powerbiVisualsApi.visuals.plugins.IVisualPlugin
import VisualConstructorOptions = powerbiVisualsApi.extensibility.visual.VisualConstructorOptions
var powerbiKey: any = "powerbi";
var powerbi: any = window[powerbiKey];

var demoDC56455BF45249BDAD6F5D882F31FDDB: IVisualPlugin = {
    name: 'demoDC56455BF45249BDAD6F5D882F31FDDB',
    displayName: 'Demo',
    class: 'Visual',
    apiVersion: '2.6.0',
    create: (options?: VisualConstructorOptions) => {
        if (Visual) {
            return new Visual(options);
        }

        throw 'Visual instance not found';
    },
    custom: true
};

if (typeof powerbi !== "undefined") {
    powerbi.visuals = powerbi.visuals || {};
    powerbi.visuals.plugins = powerbi.visuals.plugins || {};
    powerbi.visuals.plugins["demoDC56455BF45249BDAD6F5D882F31FDDB"] = demoDC56455BF45249BDAD6F5D882F31FDDB;
}

export default demoDC56455BF45249BDAD6F5D882F31FDDB;
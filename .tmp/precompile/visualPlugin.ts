import { Visual } from "../../src/visual";
import powerbiVisualsApi from "powerbi-visuals-api"
import IVisualPlugin = powerbiVisualsApi.visuals.plugins.IVisualPlugin
import VisualConstructorOptions = powerbiVisualsApi.extensibility.visual.VisualConstructorOptions
var powerbiKey: any = "powerbi";
var powerbi: any = window[powerbiKey];

var demoD24597D822144CC88F6F093AAB87041B: IVisualPlugin = {
    name: 'demoD24597D822144CC88F6F093AAB87041B',
    displayName: 'demo',
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
    powerbi.visuals.plugins["demoD24597D822144CC88F6F093AAB87041B"] = demoD24597D822144CC88F6F093AAB87041B;
}

export default demoD24597D822144CC88F6F093AAB87041B;
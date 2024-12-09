Shader "Custom/Water Shader"
{
    Properties
    {
        _MainTex ("Main Texture", 2D) = "white" {}
        _ScrollTex("Scroll Texture", 2D) = "white" {}
        _ScrollY("Scroll Speed Y", Range(0.0, 5.0)) = 1.0
        _ScrollX("Scroll Speed X", Range(0.0, 5.0)) = 1.0
        
    }
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert
        sampler2D _MainTex;
        sampler2D _ScrollTex;
        float _ScrollX;
        float _ScrollY;
        
        struct Input
        {
            float2 uv_MainTex;
        };


        void surf (Input IN, inout SurfaceOutput o)
        {
            _ScrollX *= _Time;
            _ScrollY *= _Time;
            

            float3 water = tex2D(_MainTex, IN.uv_MainTex + float2 (_ScrollX, _ScrollY)).rgb;
            float3 foam = tex2D(_MainTex, IN.uv_MainTex + float2 (_ScrollX/2.0, _ScrollY/2.0));
            o.Albedo = (foam + water)/2.0;
        }
        ENDCG
    }
    FallBack "Diffuse"
}

﻿Shader "MY/my_Toon"
{
    Properties
    {
		_Color("Color", Color) = (0.1, 0.65, 1, 1)
        _MainTex ("Texture", 2D) = "white" {}
    }
    SubShader
    {
        // Tags { "RenderType"="Opaque" }
		Tags {
			"LightMode" = "ForwardBase"
			"PassFlags" = "OnlyDirectional"
}
        // LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            // make fog work
            // #pragma multi_compile_fog

            #include "UnityCG.cginc"
			
			// populated automatically
            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
				float normal : NORMAL;
            };

			// manually populated in the vertex shader 
            struct v2f
            {
                float2 uv : TEXCOORD0;
                // UNITY_FOG_COORDS(1)
                float4 vertex : SV_POSITION;
				float3 worldNormal : NORMAL;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				// transform to world space
				o.worldNormal = UnityObjectToWorldNormal(v.normal);
                // UNITY_TRANSFER_FOG(o,o.vertex);
                return o;
            }

			float4 _Color;
			
			float4 frag (v2f i) : SV_Target
            {
                // sample the texture
                // fixed4 col = tex2D(_MainTex, i.uv);
				float4 sample = tex2D(_MainTex, i.uv);
                // apply fog
                // UNITY_APPLY_FOG(i.fogCoord, col);
			
				float3 normal = normalize(i.worldNormal);
				float NdotL = dot(_WorldSpaceLightPos0, normal);
				
				
				float lightIntensity = NdotL > 0 ? 1 : 0;
				
				return _Color * sample * lightIntensity;
            }
			
            
            ENDCG
        }
    }
}

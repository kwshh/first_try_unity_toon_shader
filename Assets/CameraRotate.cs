using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CameraRotate : MonoBehaviour
{
    private Camera myCamera;
    public Transform target;
    // public Object rotateObj;
    public float Xspeed = 1;
    public float Yspeed = 1;
    public float speed = 50;

    private void Start()
    {
        float Axis_X = 0.0f;
        float Axis_Y = 0.0f;
    }

    // Update is called once per frame
    void Update()
    {
        camerarotate();
        camerazoom();
    }

    private void camerarotate() //摄像机围绕目标旋转操作
    {
        transform.RotateAround(target.position, Vector3.up, speed * Time.deltaTime); //摄像机围绕目标旋转
        var mouse_x = Input.GetAxis("Mouse X");//获取鼠标X轴移动
        var mouse_y = -Input.GetAxis("Mouse Y");//获取鼠标Y轴移动
        if (Input.GetKey(KeyCode.Mouse1))
        {
            transform.Translate(Vector3.left * (mouse_x * 15f) * Time.deltaTime);
            transform.Translate(Vector3.up * (mouse_y * 15f) * Time.deltaTime);
        }
        if (Input.GetKey(KeyCode.Mouse0))
        {
            transform.RotateAround(target.transform.position, Vector3.up, mouse_x * 5);
            transform.RotateAround(target.transform.position, transform.right, mouse_y * 5);
        }
    }

    private void camerazoom() //摄像机滚轮缩放
    {
        if (Input.GetAxis("Mouse ScrollWheel") > 0)
            transform.Translate(Vector3.forward * 0.5f);


        if (Input.GetAxis("Mouse ScrollWheel") < 0)
            transform.Translate(Vector3.forward * -0.5f);
    }

    // 作者：白水SR
    // 链接：https://www.jianshu.com/p/dbd5c82cfb74
    // 來源：简书
    // 著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。
}

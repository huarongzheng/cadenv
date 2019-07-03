#!/usr/bin/python3
import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
from mpl_toolkits.mplot3d.art3d import Poly3DCollection, Line3DCollection

cam2rig = np.array([[-0.00714184577,   0.0456527695,   0.998931885,    1.74899995],\
                    [-0.999974251,     0.00032844051, -0.00716430973, -0.100000001],\
                    [-0.000655160227, -0.998957276 ,   0.0456492454,   1.47000003],\
                    [ 0,               0,              0,              1],\
                  ])
eye = np.mat(cam2rig[0:3,0:3])*np.mat(cam2rig[0:3,0:3]).T # cross check orthogonality

rig2cam = np.zeros((4,4))
rig2cam[0:3,0:3] = np.linalg.inv(cam2rig[0:3,0:3]) # top-left 3x3 is rotation matrix 0:3 ~ 0,1,2
rig2cam[:,3] = -cam2rig[:,3]            # right most column is translation vector
rig2cam[3,:] = [0, 0, 0, 1]             # bottom row is homogeneous parameter
eye = np.mat(rig2cam[0:3,0:3])*np.mat(rig2cam[0:3,0:3]).T # cross check orthogonality

rig2camRotation = rig2cam[0:3,0:3]
fig = plt.figure()
ax = fig.add_subplot(111, projection='3d')

# draw rig coordinate
origin = [0,0,0]
rigcoordinate = np.array([[1, 0, 0],\
                          [0, 1, 0],\
                          [0, 0, 1]
                        ])
X, Y, Z = zip(origin,origin,origin) 
U, V, W = zip(rigcoordinate[0],rigcoordinate[1],rigcoordinate[2]) # rig coordinate vector

ax.quiver(X,Y,Z,U,V,W,color='blue')

label = '(%.2f, %.2f, %.2f), rig-origin' % (origin[0], origin[1], origin[2])
ax.text(origin[0], origin[1], origin[2], label, color='blue', ha='right')
axis = ['rig-x', 'rig-y', 'rig-z']
for i in [0,1,2]:
    x, y, z = rigcoordinate[i].tolist()
    label = '%s' % (axis[i])
    ax.text(origin[0]+x, origin[1]+y, origin[2]+z, label, color='blue', ha='right')

# draw cam coordinate
origin = cam2rig[0:3,3].T
X, Y, Z = zip(origin,origin,origin) 
U, V, W = zip(rig2camRotation[0], rig2camRotation[1], rig2camRotation[2])

ax.quiver(X,Y,Z,U,V,W,color='red')

label = '(%.2f, %.2f, %.2f), cam-origin' % (origin[0], origin[1], origin[2])
ax.text(origin[0], origin[1], origin[2], label, color='red', ha='right')
axis = ['cam-x', 'cam-y', 'cam-z']
for i in [0,1,2]:
    x, y, z = rig2camRotation[i].tolist()
    label = '(%.2f, %.2f, %.2f), %s' % (x, y, z, axis[i])
    ax.text(origin[0]+x, origin[1]+y, origin[2]+z, label, color='red')


carLength = 2
# draw car/rig
v = np.array([
              [-carLength,  -1,  -1], 
              [-carLength,   1,  -1],
              [ carLength,  -1,  -1],
              [ carLength,   1,  -1],
              [-carLength,  -1,   1], 
              [-carLength,   1,   1],
              [ carLength,  -1,   1],
              [ carLength,   1,   1]
              ])

# generate list of sides' polygons of our pyramid
verts = [ [v[0],v[2],v[3],v[1]], [v[4],v[6],v[7],v[5]], [v[0],v[2],v[6],v[4]],
         [v[2],v[3],v[7],v[6]], [v[3],v[1],v[5],v[7]], [v[1],v[0],v[4],v[5]]]

## vertices of a pyramid
#v = np.array([[-1, -1, -1], [1, -1, -1], [1, 1, -1],  [-1, 1, -1], [0, 0, 1]])
#
## generate list of sides' polygons of our pyramid
#verts = [ [v[0],v[1],v[4]], [v[0],v[3],v[4]],
#         [v[2],v[1],v[4]], [v[2],v[3],v[4]], [v[0],v[1],v[2],v[3]]]

ax.scatter3D(v[:, 0], v[:, 1], v[:, 2])

# plot sides
pc = Poly3DCollection(verts, linewidths=1, edgecolors='r')
pc.set_alpha(0.1)
pc.set_facecolor('cyan')
ax.add_collection3d(pc)


ax.set_xlim([-carLength,carLength])
ax.set_ylim([-carLength,carLength])
ax.set_zlim([-carLength,carLength])
ax.set_xlabel("rig-x")
ax.set_ylabel("rig-y")
ax.set_zlabel("rig-z")

plt.show()


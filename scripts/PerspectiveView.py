#!/usr/bin/python3
import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
from mpl_toolkits.mplot3d.art3d import Poly3DCollection, Line3DCollection

cam2rig = np.matrix([[-0.00714184577,  0.0456527695,  0.998931885],\
                     [-0.999974251,    0.00032844051, -0.00716430973],\
                     [-0.000655160227, -0.998957276 , 0.0456492454]])
rig2cam = np.linalg.inv(cam2rig)
eye = rig2cam*rig2cam.transpose()

showMatrix = np.array(rig2cam)

origin = [0,0,0]
X, Y, Z = zip(origin,origin,origin) 
U, V, W = zip(showMatrix[0],showMatrix[1],showMatrix[2])

fig = plt.figure()
ax = fig.add_subplot(111, projection='3d')
ax.quiver(X,Y,Z,U,V,W)

axis = ['cam-x', 'cam-y', 'cam-z']
for i in [0,1,2]:
    x, y, z = showMatrix[i].tolist()
    label = '(%f, %f, %f), dir=%s' % (x, y, z, axis[i])
    ax.text(x, y, z, label, color='red')

ax.set_xlim([-3,3])
ax.set_ylim([-1,1])
ax.set_zlim([-1,1])
ax.set_xlabel("rig-x")
ax.set_ylabel("rig-y")
ax.set_zlabel("rig-z")


# draw car/rig
v = np.array([
              [-3,  -1,  -1], 
              [-3,   1,  -1],
              [ 3,   -1,  -1],
              [ 3,    1,  -1],
              [-3,  -1,   1], 
              [-3,   1,   1],
              [ 3,   -1,   1],
              [ 3,    1,   1]
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


plt.show()

